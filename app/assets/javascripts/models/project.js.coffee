Arc9Starter.Project = DS.Model.extend
  name: DS.attr("string")
  images: DS.hasMany("image")
  box_annotations: DS.hasMany("box_annotation")

