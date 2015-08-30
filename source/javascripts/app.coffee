#= require "lib/jquery.pjax"
#= require "lib/number-map-polyfill"

#= require "_global.coffee"
#= require "_tour-sequencer.coffee"
#= require "_map-init.coffee"
#= require "_pjax-init.coffee"

$(window).on 'resize', ->
  # The two main panels need to clear below the header:
  headerHeight = $('header').outerHeight()
  $('main, .canvas, aside.drawer').css 'padding-top', headerHeight

$(window).trigger 'resize'
