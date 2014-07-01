Arc9Starter.CanvasImageComponent = Ember.Component.extend Arc9Starter.CanvasBoxListeners,
  dragging: false
  original_x: null
  original_y: null
  x_movement: null
  y_movement: null
  boxEnabled: false

  actions:
    toggleBoxEnabled: ->
      @unbindListeners()
      @set("boxEnabled", !@get("boxEnabled"))
      @set("moveEnabled", false)
    toggleMoveEnabled: ->
      @unbindListeners()
      @set("moveEnabled", !@get("moveEnabled"))
      @set("boxEnabled", false)

  boxEnabledDidChange: (->
    if @get("boxEnabled") == true
      @bindBoxModeListeners()
  ).observes("boxEnabled")

  moveEnabledDidChange: (->
    if @get("moveEnabled") == true
      @bindMoveModeListeners()
  ).observes("moveEnabled")

  unbindListeners: ->
    canvas = @get("canvas")
    canvas.off("mousedown")
    canvas.off("mousemove")
    canvas.off("mouseup")

  bindBoxModeListeners: ->
    canvas = @get("canvas")
    canvas.on("mousedown", @boxModeMouseDown.bind(@))
    canvas.on("mousemove", @boxModeMouseMove.bind(@))
    canvas.on("mouseup", @boxModeMouseUp.bind(@))

  bindMoveModeListeners: ->
    canvas = @get("canvas")
    canvas.on("mousedown", @moveModeMouseDown.bind(@))
    canvas.on("mousemove", @moveModeMouseMove.bind(@))
    canvas.on("mouseup", @moveModeMouseUp.bind(@))

  moveModeMouseDown: (e) ->
    inShape = false
    box_x = false
    box_y = false
    @get("image").get("box_annotations").forEach (data) ->
      if data.get("x") <= e.offsetX && (data.get("x") + data.get("width")) >= e.offsetX &&
      data.get("y") <= e.offsetY && (data.get("y") + data.get("height")) >= e.offsetY
        inShape = data
    @set("inShape", inShape)
    @set("original_x", e.offsetX)
    @set("original_y", e.offsetY)

  moveModeMouseMove: (e) ->
    shape = @get("inShape")
    return unless shape
    x_movement = e.offsetX - @get("original_x")
    y_movement = e.offsetY - @get("original_y")

    image = @get("image")
    controller = @
    @get("project").get("images").forEach (image_data) ->
      if image_data.id == image.id
        image_data.get("box_annotations").forEach (data) ->
          if data.id == shape.id
            data.rollback()
            data.set("x", data.get("x") + x_movement)
            data.set("y", data.get("y") + y_movement)
            controller.set("inShape", data)

  moveModeMouseUp: ->
    return unless @get("inShape")
    @get("inShape").save()
    @unbindListeners()
    @set("moveEnabled", false)
    @get("project").reload()

  redrawCanvas: ->
    canvas = @get("canvas")
    context = @get("canvas_context")
    canvas_image = @get("canvas_image")

    context.strokeStyle = "blue"
    context.clearRect(0, 0, canvas.width(), canvas.height())
    context.drawImage(canvas_image, 0, 0)
    @get("image").get("box_annotations").forEach (data) ->
      context.strokeRect(data.get("x"), data.get("y"), data.get("width"), data.get("height"))

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

