((() ->

  #$("head").append("<link rel=\"icon\" href=\"https://raw.githubusercontent.com/isis97/isis97.github.io/master/assets/favicon.png\">")

  require './gol.coffee'
  require './nav.coffee'

  calcColDif = (from, to, perc) ->
    perc = Math.min perc, 1
    perc = Math.max perc, 0
    return [
      ((to[0]-from[0])*perc + from[0])
      ((to[1]-from[1])*perc + from[1])
      ((to[2]-from[2])*perc + from[2])
    ]

  colToRgbStr = (col) ->
    "rgb(#{parseInt(col[0])}, #{parseInt(col[1])}, #{parseInt(col[2])})"

  addScrollListener = (fn) ->
    $(window).scroll () ->
      fn(($ window).scrollTop(), ($ window).height())

  addScrollListener (s, h) ->

    el = ($ "h3.skills")
    skillsText = ($ "p.text-box.skills")

    body = $("body")

    scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0
    scrollMax = Math.max( document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight )

    #gamma = (scrollTop-el.offset().top+($ window).height()) / ($ window).height()

    gamma = (scrollTop)/scrollMax

    #gamma = Math.min (Math.max gamma, 0), 1
    console.log gamma

    rgbFrom = [220, 220, 220]
    rgbTo = [52, 73, 94]
    col = calcColDif rgbFrom, rgbTo, gamma
    #el.css 'color', (colToRgbStr col)
    #skillsText.css 'color', (colToRgbStr col)
    skillsText.css 'left', "#{parseInt(gamma*150)}px"

  addScrollListener (s, h) ->
    el = ($ ".content.first > h2")
    arr = ($ ".content.first .arrow")
    gamma = (s/h)*2
    rgbFromBg = [31, 141, 214]
    rgbToBg = [220, 220, 220]
    rgbFromFg = [255, 255, 255]
    rgbToFg = [52, 73, 94]
    colBg = calcColDif rgbFromBg, rgbToBg, gamma
    colFg = calcColDif rgbFromFg, rgbToFg, gamma
    el.css 'color', (colToRgbStr colFg)
    el.css 'background-color', (colToRgbStr colBg)
    arr.css 'border-top-color', (colToRgbStr colFg)



  rand = (from, to) -> (Math.random() * (to-from) + from)
  cutFloat = (val, cap) -> parseInt(val*cap)/cap
  randAlpha = (from, to) ->
    (cutFloat (rand from, to), 1000).toString().replace(",", ".")
  spanForLetters = (text) ->
    text = text.split ""
    ret = []
    for letter in text
      ret.push "<span class=\"letter\">#{letter}</span>"
    return (ret.join '')
  addParallaxy = (e, from, to, preserveInitialOffset=false) ->
    e = ($ e)
    w = $(window).width()
    h = $(window).height()
    bnd_w = 0.1*w
    bnd_h = 0.1*h
    e.each( () ->
      elem = $ this
      o = elem.offset()
      itop = o.top
      ileft = o.left
      if not preserveInitialOffset
        itop = 0
        ileft = 0
      ($ window).scroll () ->
        sx = 0
        sy = 0
        elem.offset {top: sx*(to-from)+from+itop, left: sy*(to-from)+from+ileft}
      ($ window).mousemove (e) ->
        sx = Math.max(Math.min(1, event.pageX/(w-bnd_w)), 0)
        sy = Math.max(Math.min(1, event.pageY/(h-bnd_h)), 0)
        elem.offset {top: sx*(to-from)+from+itop, left: sy*(to-from)+from+ileft}
      #($ window).scroll () ->
      #  elem.offset {top: itop, left: ileft}
    )

  ($ document).ready (() ->

    ($ ".card-container").hover (() ->
      logoColor = $(this).attr('data-logo-color')
      $(this).find('.card-font-icon').css('color', logoColor)
    ), (() ->
      $(this).find('.card-font-icon').css('color', 'inherit')
    )
  
    ($ "#splash-anim").typed
      strings: ["int main(void) { main(); }", "++--[+]", "while [ 1 ]; done"]
      showCursor: true
      cursorChar: "|"
      contentType: 'html'
      typeSpeed: 50
      backDelay: 2000
      backSpeed: 90
      shuffle: true
      loop: true

    ($ '#hiremebutton').click () ->
      ($ 'html, body').animate {
        scrollTop: ($ "#contactme").offset().top
      }, 1300

    addParallaxy [($ '.splash-head')], -10, 10
    #addParallaxy [($ '.splash-subbutton')], -20, 20
    addParallaxy [($ '#golcanvas')], -50, 100
    #addParallaxy [($ '#calendar_ribbon')], -50, 100
    #($ '.card-container').each () ->
    #  el = ($ this)
    #  addParallaxy el, -Math.random()*30-10, Math.random()*30+10, true
    ###
    (GitHubCalendar ".calendar", "isis97", {
      summary_text: false
      global_stats: false
    }).then () ->
      console.log "Ready"
      cal = ($ ".calendar")
      svg = cal.find("svg")
      svg.find("text").remove()
      rootG = svg.find("g").first()
      rootG.attr('transform', "translate(-29, -5) scale(2,1.5)")

      cal.empty()
      svg.appendTo ($ "#calendar_ribbon")
      cal.remove()
      svg.attr('width', 900).attr('height', 104)
    ###

    #scrollTo(0,0)
    window.loaderIncr(10, "Index script fully-ready loaded.")
    checkfCounter = 0
    checkf = () ->
      ++checkfCounter
      siz = $("*").length
      if (siz>40000) || (checkfCounter>1)
        window.loaderAddReadyWrappers()
      else
        console.log "wait"
        setTimeout checkf, 500
    setTimeout checkf, 500
    ###window.test = () ->
      ($ ".logo").children().each (e) ->
        genTextShadow =  []
        for i in [0..(rand 0, 10)] by 1
          genTextShadow.push "rgba(255, 255, 255, #{randAlpha(0.0, 1.0)})  #{i}px #{i}px"
        genTextShadow = genTextShadow.join ','
        ($ this).css
          "text-shadow": genTextShadow###
  )

  window.loaderIncr(0, "Index script loaded.")

)())
