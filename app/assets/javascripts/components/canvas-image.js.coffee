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
