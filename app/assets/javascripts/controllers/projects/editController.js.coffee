Arc9Starter.ProjectsEditController = Ember.ObjectController.extend
  content: {}
  actions:
    updateProject: ->
      @get("project").save()

