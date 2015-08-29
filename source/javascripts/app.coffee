#= require "lib/jquery.pjax"

#= require "_global.coffee"
#= require "_tour-sequencer.coffee"
#= require "_map-init.coffee"
#= require "_pjax-init.coffee"

$(window).on 'resize', ->
  # The two main panels need to clear below the header:
  $('main, .canvas').css 'padding-top', $('header').outerHeight()

$(window).trigger 'resize'
