# For more information see: http://emberjs.com/guides/routing/

Arc9Starter.Router.map ()->
  @resource "projects", {path: "/projects"}, ->
    @route "edit", path: "/:project_id/edit"
    @route "show", path: "/:project_id"

Arc9Starter.IndexRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo "projects"

Arc9Starter.ProjectsRoute = Ember.Route.extend
  model: ->
    @store.find "project"

Arc9Starter.ProjectsEditRoute = Ember.Route.extend
  setupController: (controller, model) ->
    controller.set "project", model
