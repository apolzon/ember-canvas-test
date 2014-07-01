Arc9Starter.CanvasImageComponent = Ember.Component.extend
  dragging: false
  original_x: null
  original_y: null
  x_movement: null
  y_movement: null
  boxEnabled: false
  textEnabled: false

  actions:
    toggleBoxEnabled: ->
      @unbindListeners()
      @set("boxEnabled", !@get("boxEnabled"))
      @set("textEnabled", false)
    toggleTextEnabled: ->
      @unbindListeners()
      @set("textEnabled", !@get("textEnabled"))
      @set("boxEnabled", false)

  boxEnabledDidChange: (->
    if @get("boxEnabled") == true
      @bindBoxModeListeners()
  ).observes("boxEnabled")

  textEnabledDidChange: (->
    if @get("textEnabled") == true
      @bindTextModeListeners()
  ).observes("textEnabled")

  bindBoxModeListeners: ->
    canvas = @get("canvas")
    canvas.on("mousedown", @boxModeMouseDown.bind(@))
    canvas.on("mousemove", @boxModeMouseMove.bind(@))
    canvas.on("mouseup", @boxModeMouseUp.bind(@))

  unbindListeners: ->
    canvas = @get("canvas")
    canvas.off("mousedown")
    canvas.off("mousemove")
    canvas.off("mouseup")

  bindTextModeListeners: ->
    canvas = @get("canvas")
    canvas.on("mousedown", @textModeMouseDown.bind(@))
    canvas.on("mousemove", @textModeMouseMove.bind(@))
    canvas.on("mouseup", @textModeMouseUp.bind(@))

  redrawCanvas: ->
    canvas = @get("canvas")
    context = @get("canvas_context")
    canvas_image = @get("canvas_image")

    context.strokeStyle = "blue"
    context.clearRect(0, 0, canvas.width(), canvas.height())
    context.drawImage(canvas_image, 0, 0)
    @get("image").get("box_annotations").forEach (data) ->
      context.strokeRect(data.get("x"), data.get("y"), data.get("width"), data.get("height"))

  boxModeMouseDown: (e) ->
    @set("original_x", e.offsetX)
    @set("original_y", e.offsetY)
    @set("dragging", true)

  boxModeMouseUp: ->
    @set("dragging", false)
    ba = @get("store").createRecord "box_annotation",
      x:       @get("original_x"),
      y:       @get("original_y"),
      width:   @get("x_movement"),
      height:  @get("y_movement"),
      image:   @get("image"),
      project: @get("project")
    # would be better to bulk save the project, but had trouble finding a clean way to
    # get the related image out of the project object for updating
    # (if we pull the image directly out of the store, the project.images recordarray is not updated)
    ba.save()

  boxModeMouseMove: (e) ->
    return unless (@get("dragging") == true)
    @set("x_movement", e.offsetX - @get("original_x"))
    @set("y_movement", e.offsetY - @get("original_y"))

    @redrawCanvas()
    @get("canvas_context").strokeRect(@get("original_x"), @get("original_y"), @get("x_movement"), @get("y_movement"))

  textModeMouseDown: ->
    console.log "text mousedown"
  textModeMouseMove: ->
    console.log "text move"
  textModeMouseUp: ->
    console.log "text up"

  didInsertElement: ->
    canvas = this.$("canvas")
    @set("canvas", canvas)
    store = @get("store")
    context = canvas[0].getContext("2d")
    @set("canvas_context", context)
    project = @get("project")
    canvas_image = new Image()
    @set("canvas_image", canvas_image)
    canvas_image.onload = (->
      canvas.attr("width", canvas_image.width)
      canvas.attr("height", canvas_image.height)
      @redrawCanvas()
    ).bind(@)
    canvas_image.src = @get("image").get("url")

