//= require_tree .
$(window).on 'resize', ->
  $('main, .canvas').css 'padding-top', $('header').outerHeight()

cartodb.createVis 'invest', $('#invest').data 'map-url'

$(window).trigger 'resize'
