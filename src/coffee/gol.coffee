module.exports = ((() ->

  #  aliveColour = [198, 45, 66, 1]
  aliveColour = [150, 150, 150, 1]
  deadColour  = [66, 66, 66, 0.1]

  waitForFinalEvent = (() ->
    timers = {}
    return (callback, ms, uniqueId) ->
      if !uniqueId
        uniqueId = "Don't call this twice without a uniqueId"
      if timers[uniqueId]
        clearTimeout timers[uniqueId]
      timers[uniqueId] = setTimeout(callback, ms)
  )()

  Array.prototype.unique = () ->
    a = @concat()
    for i in [0..a.length-1] by 1
      for j in [i+1..a.length-1] by 1
        if a[i] == a[j]
          a.splice j--, 1
    return a

  escape = (s) -> s.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&')

  class CanvasHandlerPromise
    bodyFn: null
    next: null
    root: null
    constructor: (@root, parent, @bodyFn) ->
    flush: () ->
      @root.canvasHandler.flush()
    call: (label) ->
      tgt = @root.promiseLabels[label]
      if tgt?
        @next = tgt
        return @next
      else
        return this
    label: (label) ->
      @root.promiseLabels[label] = this
    workOn: (label) ->
      tgt = @root.promiseLabels[label]
      if tgt?
        return tgt
      else
        return this
    on: (obj, event) ->
      capturedCanvas = null
      @next = new CanvasHandlerPromise @root, this, (c) ->
        capturedCanvas = c
      ($ obj).on event, () =>
        waitForFinalEvent () =>
          if capturedCanvas?
            capturedCanvas.update()
            @next.execute(capturedCanvas)
        , 500, "CHPromiseWindowResize"
      return @next
    paint: (fn) ->
      @next = new CanvasHandlerPromise @root, this, fn
      return @next
    execute: (c) ->
      if not c?
        c = @root?.canvasHandler?.canvas
      if @bodyFn?
        if @bodyFn.paint?
          @bodyFn.paint c
        else
          @bodyFn c
      @next?.execute c

  class CanvasHandler
    canvas: null
    paintQueue: null
    props: null
    flush: () ->
      @canvas.update()
      @paintQueue.execute @canvas
    ready: () -> @paintQueue
    updateCanvas: () ->
      c = $ (@props.id)
      ctx = c[0].getContext("2d")
      props = @props
      @canvas = {
        x: ctx
        dom: c
        w: 0
        h: 0
        update: () ->
          @w = (props.w())
          @h = (props.h())
          @x.canvas.width = @w
          @x.canvas.height = @h
      }
      @canvas.update()
    constructor: (@props) ->
      @paintQueue = new CanvasHandlerPromise {
        canvasHandler: this
        promiseLabels: []
      }, null, () ->
      ($ document).ready () =>
        @updateCanvas()
        @flush()
  handleCanvas = (props) ->
    h = new CanvasHandler(props)
    window.canvasHandler = h
    return h.ready()
  repaintCanvas = () ->
    window.canvasHandler.flush()

  class GOLMap
    map: null
    mapBuffer: null
    alphaMask: null
    w: 0
    h: 0
    conditioner: null
    initMatrix: () ->
      v = []
      for x in [0..@w] by 1
        v.push []
        for y in [0..@h] by 1
          v[x].push 0
      return v
    constructor: (@w, @h, @conditioner) ->
      @map = @initMatrix()
      @mapBuffer = @initMatrix()
      @alphaMask = @initMatrix()
      map_c_x = @w / 2.0
      map_c_y = @h / 2.0
      f_x = 1.0
      f_y = 3.0
      fi_lower_l = 0.0
      fi_upper_l = 1.0
      fi_upper_rl = 0.9
      fi_lower_rl = 0.0
      map_maxd = Math.sqrt(f_x*map_c_x*map_c_x+f_y*map_c_y*map_c_y+0.1)*0.7
      for x in [0..@w] by 1
        for y in [0..@h] by 1
          fi = 1-( Math.sqrt(f_x*(x-map_c_x)*(x-map_c_x)+f_y*(y-map_c_y)*(y-map_c_y))/map_maxd )
          if fi > fi_upper_rl
            fi = fi_upper_l
          if fi < fi_lower_rl
            fi = fi_lower_l
          fi = Math.max fi_lower_l, fi
          fi = Math.min fi_upper_l, fi
          @alphaMask[x][y] = fi
    set: (x, y, name) ->
      if @map[x]?
        if @map[x][y]?
          @map[x][y] = @conditioner.translateStateName name
    drawStructure: (x, y, obj) ->
      for k, v of obj
        k = k.split ","
        @set ((parseInt k[0])+x), ((parseInt k[1])+y), v
    step: (movx, movy) ->
      movx = 0 if not movx?
      movy = 0 if not movy?
      for x in [0..@w] by 1
        for y in [0..@h] by 1
          @mapBuffer[x][y] = @conditioner.step x, y, @map
      for x in [movx..@w-movx] by 1
        for y in [movy..@h-movy] by 1
          @map[x][y] = @mapBuffer[x+movx][y+movy]
    paint: (c) ->
      zoom = 1.5
      field_margin_left = 2
      field_margin_top = 2
      field_w = (c.w*zoom) / @w
      field_h = (c.h*zoom) / @h

      field_w = Math.min field_w, field_h
      field_h = field_w
      totw = field_w * @w
      toth = field_h * @h

      shift_x = (c.w - totw) / 2.0
      shift_y = (c.h - toth) / 2.0

      field_rw = field_w - field_margin_left
      field_rh = field_h - field_margin_top
      for x in [0..@w] by 1
        for y in [0..@h] by 1
          c.x.save()
          c.x.translate(x*field_w+shift_x, y*field_h+shift_y)
          rgba = @conditioner.colour @map[x][y]
          rgba[3] *= @alphaMask[x][y]

          c.x.fillStyle = "rgba(" + (rgba.join ',') + ")"
          c.x.fillRect(-field_rw, -field_rh, field_rw, field_rh)
          c.x.restore()


  golUtils = {
    count: (l) ->
      l.length

    rangeCircle: (map, x0, y0, r) ->
      ret = []
      for x in [x0-r..x0+r] by 1
        for y in [y0-r..y0+r] by 1
          if (x-x0)*(x-x0)+(y-y0)*(y-y0) <= r*r
            if map[x]?
              if map[x][y]?
                ret.push map[x][y]
      return ret

    rangeDistStraight: (map, x0, y0, r) ->
      ret = []
      for x in [x0-r..x0+r] by 1
        for y in [y0-r..y0+r] by 1
          if ((x-x0)*(x-x0)+(y-y0)*(y-y0)) == (r*r)
            if map[x]?
              if map[x][y]?
                ret.push map[x][y]
      return ret

    rangeDist: (map, x0, y0, r) ->
      ret = []
      for x in [x0-r..x0+r] by 1
        for y in [y0-r..y0+r] by 1
          d = (x-x0)*(x-x0)+(y-y0)*(y-y0)
          if d >= (r*r) && d < ((r+1)*(r+1))
            if map[x]?
              if map[x][y]?
                ret.push map[x][y]
      return ret

    filter: (l, p) ->
      l.filter p
  }

  compileCodeToConditioner = (code) ->
    ncode = ""
    defaultDecl = null
    defaultStateDecl = /^([ a-zA-Z0-9->,]+?)$/gm
    match = defaultStateDecl.exec code
    if match != null
      defaultDecl = match[0]
      code = code + "\n#{defaultDecl}: true\n"
    matchDecl = /([ a-zA-Z0-9->,]+?):(.*)/gm
    match = matchDecl.exec code
    varDecls = ""
    while match != null
      if match[1].indexOf("set ") != -1
        spl = (match[1].split(" "))[1]
        varDecls += "var #{spl} = #{match[2]};\n"
      else
        ncode += "#{match[1]}: #{match[2]}\n"
      match = matchDecl.exec code
    matchStatesDecl = /([a-zA-Z0-9->,]+?):(.*)/gm
    code = ncode
    statesNames = []
    statesNamesAliases = {}
    match = matchStatesDecl.exec code
    while match != null
      statesNames = statesNames.concat(match[1].split(/->|,/g)).unique()
      match = matchStatesDecl.exec code
    statesNames = statesNames.sort (a, b) ->
      if a.length == b.length
        return b-a
      else
        return b.length-a.length
    if defaultDecl != null
      statesNamesAliases[defaultDecl] = 0
      i = 1
      for alias in statesNames
        if alias != defaultDecl
          statesNamesAliases[alias] = i
          ++i
    else
      i = 0
      for alias in statesNames
        statesNamesAliases[alias] = i
        ++i
    match = matchStatesDecl.exec code
    ncode = ""
    while match != null
      dir = match[1].split("->")
      C = match[2].trim()
      if dir.length == 2
        dir1 = dir[0].split(",")
        dir2 = dir[1].split(",")
        for A in dir1
          for B in dir2
            #ncode += "#{A}->#{B}: #{C}\n"
            ncode += "#{B}: is(#{A}) && (#{C})\n"
      else
        dir1 = dir[0].split(",")
        for A in dir1
          ncode += "#{A}: #{C}\n"
      match = matchStatesDecl.exec code
    code = ncode
    match = matchStatesDecl.exec code
    ncode = ""
    while match != null
      B = match[2].trim()
      A = match[1].trim()
      ncode += "if(#{B}) {return (#{A});}\n"
      match = matchStatesDecl.exec code
    code = ncode
    prfdecl = ""
    for alias in statesNames
      prfdecl += "var #{alias} = #{statesNamesAliases[alias]};\n"
    prfdecl += """
      var self = map[x][y];
      var get = function(x0, y0) {
        if(map[x0] === undefined) {
          return null;
        }
        if(map[x0][y0] === undefined) {
          return null;
        }
        return map[x0][y0];
      };
      var filterValue = function(t, v) { return t.filter(function(e){return e === v;}); };
      var circle = function(r) { return golUtils.rangeCircle(map,x,y,r); };
      var countCircleValues = function(r, v) { return (filterValue(circle(r),v)).length; };
      var range = function(r) { return golUtils.rangeDist(map,x,y,r); };
      var countRangeValues = function(r, v) { return (filterValue(range(r),v)).length; };
      var rangeStraight = function(r) { return golUtils.rangeDistStraight(map,x,y,r); };
      var countRangeStraightValues = function(r, v) { return (filterValue(rangeStraight(r),v)).length; };
      var is = function(o, value) {
        if(value === undefined) {
          return map[x][y] === o;
        }
        return o === value;
      };
      var $ = function(xr, yr) { return map[xr+x][yr+y]; };
    """
    code = prfdecl + "\n" + varDecls + code
    conditioner = {
      colour: (v) ->
        v = v % @states
        [
          Math.min(aliveColour[0], deadColour[0]) + (v/(@states-1))*Math.abs(aliveColour[0] - deadColour[0])
          Math.min(aliveColour[1], deadColour[1]) + (v/(@states-1))*Math.abs(aliveColour[1] - deadColour[1])
          Math.min(aliveColour[2], deadColour[2]) + (v/(@states-1))*Math.abs(aliveColour[2] - deadColour[2])
          Math.min(aliveColour[3], deadColour[3]) + (v/(@states-1))*Math.abs(aliveColour[3] - deadColour[3])
        ]
    }
    conditioner.translateStateName = (name) ->
      if not statesNamesAliases[name]?
        if defaultDecl != null
          return 0
        else
          return 0
      return statesNamesAliases[name]
    conditioner.states = statesNames.length
    code = "(function(x, y, map){\n#{code}})"
    #console.log code
    fn = eval code
    conditioner.step = fn
    return conditioner


  condNormal = (compileCodeToConditioner """
  set k: countRangeValues(1, Live)
  Live->Dead: k<2
  Live->Dead: k>3
  Live->Live: k == 2 || k == 3
  Dead->Live: k == 3
  Dead
  """
  )

  condSmile = (compileCodeToConditioner """
  set k: ['16x11', '15x12', '15x13', '15x14', '15x15', '15x16', '16x17', '22x12', '22x16']
  set n: countRangeValues(1, Live)
  Live: (k.indexOf([x, y].join('x')) !== -1) && (Math.random()>0.1)
  Live->Dead: (Math.random()>0.99)
  Dead
  """
  )

  condWaves =  (compileCodeToConditioner """
  set k: countRangeValues(2, Live)
  Live->Tail: true
  Tail->None: true
  None->Live: k > 1
  None
  """
  )

  val = "Live"

  #                80, 50
  map = new GOLMap 30, 30, condWaves

  conds = [
    {
      c: condNormal
      needBump: true
    }
    {
      c: condSmile
      needBump: false
    }
    {
      c: condWaves
      needBump: true
    }
  ]

  c = handleCanvas({
    id: '#golcanvas'
    w: () -> $(window).width() #$('#golcanvas').width()
    h: () -> $(window).height() #$('#golcanvas').height()
  })
  #$('#golcanvas').width($(window).width())
  #$('#golcanvas').height($(window).height())

  makeSomeStuff = (strength) ->
    box_x_rng = [5, 30]
    box_y_rng = [5, 30]
    prb = Math.random()*10
    for j in [0..prb] by 1
      num = Math.random() * strength + 10
      for i in [0..num] by 1
        if Math.random() > 0.5
          x0 = Math.random()*(box_x_rng[1]-box_x_rng[0])+box_x_rng[0]
          y0 = Math.random()*(box_y_rng[1]-box_y_rng[0])+box_y_rng[0]
          x0 = parseInt x0
          y0 = parseInt y0
          map.set x0, y0, val

  t = 101
  g = 101
  cCnt = parseInt(Math.random() * conds.length * 2) % conds.length
  step = () ->
    if g>1
      cCnt++
      cCnt = cCnt % conds.length
      map.conditioner = conds[cCnt].c
      g = 0
      t = 0
      if conds[cCnt].needBump
        makeSomeStuff(100)
    if t>10
      if conds[cCnt].needBump
        makeSomeStuff(10)
      ++g
      t = 0
    s = 0
    map.step(s, s)
    c.flush()
    ++t

  window.step = () ->
    step()

  setInterval () ->
    step()
  , 500

  c
  .on(window, 'resize')
  .paint (c) ->
    c.x.fillStyle = 'rgba(0, 45, 66, 0.1)'
    c.x.fillRect(0, 0, c.w, c.height)
  .paint map


)())
