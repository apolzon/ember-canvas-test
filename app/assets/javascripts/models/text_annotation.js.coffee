Arc9Starter.TextAnnotation = DS.Model.extend
  body:     DS.attr("string")
  x:        DS.attr("string")
  y:        DS.attr("string")
  image:    DS.belongsTo("image")