module.exports = (() ->
  ($ window).ready () ->
    navSections = []
    navSectionsDom = ($ 'span.navsection')
    navSectionsDom.each () ->
      thiz = ($ this)
      navSections.push {
        title: (thiz.text())
        dom: thiz
        pos: thiz.offset().top
        vpos: 0
        vdur: 0
      }
    navSections.sort (x, y) -> x.pos - y.pos
    len = navSections.length
    body = ($ 'body')
    curS = body.scrollTop()
    maxS = (body.prop "scrollHeight") - (($ window).height())
    posn = -1
    posn_c = 0
    for i in [0..len-1] by 1
      navSections[i].pos = navSections[i].dom.offset().top
      if i == len-1
        navSections[i].dur = maxS - navSections[i].pos + (($ window).height())
      else
        navSections[i].dur = navSections[i+1].pos-navSections[i].pos
      navSections[i].vpos = navSections[i].pos + navSections[i].dur / 2
      if i == len-1
        navSections[i].vdur = maxS - navSections[i].vpos + (($ window).height())
      else
        navSections[i].vdur = navSections[i+1].vpos-navSections[i].vpos
      if (curS >= navSections[i].vpos) && (curS <= navSections[i].vpos+navSections[i].vdur) && (posn == -1)
        posn = i
        posn_c = (curS - navSections[i].pos)/navSections[i].dur
    posn_c = Math.pow(Math.sin(posn_c*Math.PI), 2)*0.6 + 0.4

    nav = ($ '.navbar:first')
    for i in [0..len-1] by 1
      el = $ "<div class=\"boxy nav\"><span>#{navSections[i].title}</span></div>"
      (() ->
        loctgt = navSections[i].dom
        loci = i
        el.click () ->
          pos = navSections[loci].vpos - (if (loci>0) then (navSections[loci-1].vdur*0.7) else (1000)) + body.scrollTop()
          ($ 'html, body').animate {
            scrollTop: pos
          }, 500
      )()
      navSections[i].navdom = el
      el.appendTo nav

    #for i in [0..len-1] by 1
    #  navSections[i].navdom.css 'height', "#{Math.round(200*navSections[i].dur/maxS)}px"

    navpar = ($ '.navbar:first')
    nav = navpar.children()
    ($ window).scroll () ->

      curS = body.scrollTop()
      maxS = (body.prop "scrollHeight") - (($ window).height())

      navopacity = 1
      if curS > ($ window).height()+150
        navopacity = 1
      else
        navopacity = Math.min( 1, Math.max(0, (curS/($ window).height()*2)) )
      navpar.css 'opacity', navopacity

      posn = 0
      posn_c = 0
      for i in [0..len-1] by 1
        navSections[i].pos = navSections[i].dom.offset().top
      navSections.sort (x, y) -> x.pos - y.pos
      for i in [0..len-1] by 1
        if i == len-1
          navSections[i].dur = maxS - navSections[i].pos + (($ window).height())
        else
          navSections[i].dur = navSections[i+1].pos-navSections[i].pos
      for i in [0..len-1] by 1
        navSections[i].vpos = navSections[i].pos + navSections[i].dur / 2
      for i in [0..len-1] by 1
        if i == len-1
          navSections[i].vdur = maxS - navSections[i].vpos + (($ window).height())
        else
          navSections[i].vdur = navSections[i+1].vpos-navSections[i].vpos
      for i in [0..len-1] by 1
        if (curS >= navSections[i].vpos) && (curS <= navSections[i].vpos + navSections[i].vdur)
          posn = i
          posn_c = (curS - navSections[i].pos)/navSections[i].dur
      posn_c = Math.pow(Math.sin(posn_c*Math.PI), 2)*0.6 + 0.4


      #console.log "posn=#{posn} / posn_c=#{posn_c}"
      i = 0
      nav.each () ->
        el = ($ this)
        shift = 45
        if i == posn
          #shift = 45 + Math.cos(posn_c * Math.PI) * 25
          el.addClass 'active'
          el.find('span').css 'opacity', 0.2 + 0.9*posn_c
        else
          el.removeClass 'active'
          el.find('span').css 'opacity', 0.2
        #el.offset {
        #  left: ($ window).width()-shift
        #}
        ++i
)()
