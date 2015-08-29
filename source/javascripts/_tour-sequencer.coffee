# Sequencer

window.MC.Classes.Sequencer ||= class Sequencer
  constructor: (@map) ->
    @layers = []
    @steps = for step in $('main article.step')
      new MC.Classes.Step $(step), @

    @map.done (vis, layers) => @setup vis, layers

  setup: (vis, layers) ->
    for layer in layers
      @layers.push layer
      # for sublayer in [0..layer.getSubLayerCount()]
        # @sub_layers.push layer.getSubLayer sublayer

      @listen()
      @poll()

  listen: ->
    $(window).scroll (e) =>
      @poll e

  poll: (e) ->
    visible = @get_visible()
    @activate visible unless visible is @current

  activate: (step) ->
    @current?.exit()
    @current = step
    @current.enter()

  get_visible: ->
    for step in @steps
      return step if step.el.offset().top / $(document.body).height() > @get_offset()
    @steps[@steps.length - 1]

  get_offset: ->
    $(window).scrollTop() / ( $(document.body).height() - $(window).height() )

  pan: (lat, lng) ->
    @map.map.setCenter [lat, lng]

  zoom: (level) ->
    @map.map.setZoom level


# Individual Steps

window.MC.Classes.Step ||= class Step
  constructor: (@el, @sequencer) ->
    @data = @el.data()
    # console.log @

  enter: ->
    @el.addClass 'current'
    @center()
    console.log @

  exit: ->
    @el.removeClass 'current'
    console.log @

  center: ->
    @sequencer.pan @data.lat, @data.lng

  zoom: ->
    @sequencer.zoom @data.zoom
