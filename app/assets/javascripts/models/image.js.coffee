Arc9Starter.Image = DS.Model.extend
  url:              DS.attr("string")
  project:          DS.belongsTo("project")
  box_annotations:  DS.hasMany("box_annotation")
