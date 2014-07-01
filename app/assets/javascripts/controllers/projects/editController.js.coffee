Arc9Starter.ProjectsEditController = Ember.ObjectController.extend
  content:
    boxEnabled: false
    textEnabled: false
  actions:
    toggleBoxEnabled: ->
      @set("boxEnabled", !@get("boxEnabled"))
      @set("textEnabled", false)
    toggleTextEnabled: ->
      @set("textEnabled", !@get("textEnabled"))
      @set("boxEnabled", false)
    updateProject: ->
      @get("project").save()

