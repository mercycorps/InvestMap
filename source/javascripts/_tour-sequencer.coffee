# Sequencer

window.MC.Classes.Sequencer ||= class Sequencer
  constructor: (@map, @key) ->
    @layers = []
    @steps = for step in $('main article.step')
      new MC.Classes.Step $(step), @

    @map.done (vis, layers) => @setup vis, layers

  setup: (vis, layers) ->
    for i in [1..(layers.length - 1)]
      layer = layers[i]
      # Skip the first layer, because that's the actual map!
      if layer.type? && layer.type == 'layergroup'
        for sublayer in [0..(layer.getSubLayerCount() - 1)]
          @layers.push new MC.Classes.MapLayer layer.getSubLayer sublayer
      else
        @layers.push new MC.Classes.MapLayer layer

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
    @show @current.data.layers

  get_visible: ->
    for step in @steps
      return step if step.el.offset().top / $(document.body).height() > @get_offset()
    @steps[@steps.length - 1]

  get_offset: ->
    $(window).scrollTop() / ( $(document.body).height() + 250 - $(window).height() )

  pan: (lat, lng) ->
    @map.map.setCenter [lat, lng]

  zoom: (level) ->
    @map.map.setZoom level

  find_layer: (key) ->
    @layers[@key[key]]

  show: (ids) ->
    console.log 'showing', ids
    
    # Hide all layers
    layer.hide() for layer in @layers

    # Show just those that are in the map name key
    for id in ids
      @find_layer(id).show()

# Map Layers (Wrapper for CartDBLayer API)

window.MC.Classes.MapLayer ||= class MapLayer
  constructor: (@layer) ->
    @type = if @layer.type? then @layer.type else 'unknown'
    # @data = @layer.getAttributes()

  hide: ->
    if @type == 'torque'
      @layer.stop()
    else
      @layer.hide()

  show: ->
    if @type == 'torque'
      @layer.play()
    else
      @layer.show()

# Individual Steps

window.MC.Classes.Step ||= class Step
  constructor: (@el, @sequencer) ->
    @data = @el.data()
    @data.layers = @data.layers.split ','

  enter: ->
    @el.addClass 'current'
    @center()
    @zoom()

  exit: ->
    @el.removeClass 'current'

  center: ->
    @sequencer.pan @data.lat, @data.lng

  zoom: ->
    @sequencer.zoom @data.zoom
