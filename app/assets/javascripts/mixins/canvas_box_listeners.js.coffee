Arc9Starter.CanvasBoxListeners = Ember.Mixin.create
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
