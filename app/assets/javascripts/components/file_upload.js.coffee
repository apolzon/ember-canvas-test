Arc9Starter.FileUploadComponent = Ember.FileField.extend
  url: ""
  filesDidChange: (->
    project = @get("project")
    store = @get("store")

    uploadUrl = "/projects/" + @get("model_id") + "/upload_files"
    files = @get("files")

    uploader = Ember.Uploader.create
      url: uploadUrl

    if !Ember.isEmpty(files)
      uploader.upload(files[0]).then (response) ->
        stored_image = store.push("image", response.image)
        project.get("images").pushObject(stored_image)


  ).observes("files")
