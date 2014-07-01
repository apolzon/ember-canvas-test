Arc9Starter.BoxAnnotation = DS.Model.extend
  x:        DS.attr("number")
  y:        DS.attr("number")
  width:    DS.attr("number")
  height:   DS.attr("number")
  image:    DS.belongsTo("image")
  project:  DS.belongsTo("project")