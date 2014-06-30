Arc9Starter.BoxAnnotation = DS.Model.extend
  x:        DS.attr("string")
  y:        DS.attr("string")
  width:    DS.attr("string")
  height:   DS.attr("string")
  image:    DS.belongsTo("image")
  project:  DS.belongsTo("project")