Arc9Starter.CanvasImageComponent = Ember.Component.extend
  tagName: "canvas"

  didInsertElement: ->
    console.log "component content", @get("content")
    canvas = this.$()
    store = @get("store")
    context = canvas[0].getContext("2d")
    image_obj = @get("image")
    project = @get("project")
    image = new Image()
    image.onload = ->
      canvas.attr("width", image.width)
      canvas.attr("height", image.height)
      redrawCanvas()
    image.src = @get("image").get("url")

    dragging = false
    original_x = null
    original_y = null
    x_movement = null
    y_movement = null

    redrawCanvas = (->
      context.strokeStyle = "blue"
      context.clearRect(0, 0, canvas.width(), canvas.height())
      context.drawImage(image, 0, 0)
      @get("image").get("box_annotations").forEach (data) ->
        context.strokeRect(data.get("x"), data.get("y"), data.get("width"), data.get("height"))
    ).bind(@)

    canvas[0].addEventListener "mousedown", (e) ->
      original_x = e.offsetX
      original_y = e.offsetY
      dragging = true

    canvas[0].addEventListener "mouseup", ->
      dragging = false
      ba = store.createRecord "box_annotation",
        x:      original_x,
        y:      original_y,
        width:  x_movement,
        height: y_movement,
        image:  image_obj,
        project: project
      # would be better to bulk save the project, but had trouble finding a clean way to
      # get the related image out of the project object for updating
      # (if we pull the image directly out of the store, the project.images recordarray is not updated)
      ba.save()

    canvas[0].addEventListener "mousemove", (e) ->
      return unless dragging
      x_movement = e.offsetX - original_x
      y_movement = e.offsetY - original_y

      redrawCanvas()
      context.strokeRect(original_x, original_y, x_movement, y_movement)
