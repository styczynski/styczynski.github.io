((() ->

  require './gol.coffee'
  require './nav.coffee'

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
      ($ window).mousemove (e) ->
        sx = Math.max(Math.min(1, event.pageX/(w-bnd_w)), 0)
        sy = Math.max(Math.min(1, event.pageY/(h-bnd_h)), 0)
        elem.offset {top: sx*(to-from)+from+itop, left: sy*(to-from)+from+ileft}
      #($ window).scroll () ->
      #  elem.offset {top: itop, left: ileft}
    )

  ($ document).ready (() ->

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

    scrollTo(0,0)
    ###window.test = () ->
      ($ ".logo").children().each (e) ->
        genTextShadow =  []
        for i in [0..(rand 0, 10)] by 1
          genTextShadow.push "rgba(255, 255, 255, #{randAlpha(0.0, 1.0)})  #{i}px #{i}px"
        genTextShadow = genTextShadow.join ','
        ($ this).css
          "text-shadow": genTextShadow###
  )

)())
