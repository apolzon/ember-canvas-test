Arc9Starter.Image = DS.Model.extend
  url: DS.attr("string")
  project: DS.belongsTo("project")
