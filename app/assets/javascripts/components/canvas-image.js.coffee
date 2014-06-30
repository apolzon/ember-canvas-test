Arc9Starter.CanvasImageComponent = Ember.Component.extend
  tagName: "canvas"

  didInsertElement: ->
    canvas = this.$()
    context = canvas[0].getContext("2d")
    image = new Image()
    image.onload = ->
      canvas.attr("width", image.width)
      canvas.attr("height", image.height)
      context.drawImage(image, 0, 0)
    image.src = @get("src")

    dragging = false

    original_x = null
    original_y = null
    x_movement = null
    y_movement = null

    rects = []

    redrawCanvas = ->
      context.clearRect(0, 0, canvas.width(), canvas.height())
      context.drawImage(image, 0, 0)
      for rect in rects
        context.strokeRect(rect[0], rect[1], rect[2], rect[3])

    canvas[0].addEventListener "mousedown", (e) ->
      original_x = e.offsetX
      original_y = e.offsetY
      dragging = true

    canvas[0].addEventListener "mouseup", ->
      dragging = false
      new_rect = [original_x, original_y, x_movement, y_movement]
      rects.push(new_rect)

    canvas[0].addEventListener "mousemove", (e) ->
      return unless dragging
      x_movement = e.offsetX - original_x
      y_movement = e.offsetY - original_y

      context.strokeStyle = "blue"
      redrawCanvas()
      context.strokeRect(original_x, original_y, x_movement, y_movement)
