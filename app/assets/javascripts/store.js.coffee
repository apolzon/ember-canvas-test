# http://emberjs.com/guides/models/#toc_store
# http://emberjs.com/guides/models/pushing-records-into-the-store/

# Override the default adapter with the `DS.ActiveModelAdapter` which
# is built to work nicely with the ActiveModel::Serializers gem.
Arc9Starter.ApplicationAdapter = DS.ActiveModelAdapter.extend({
  adapter: "-activemodel"
})

token = $('meta[name="csrf-token"]').attr('content')
$.ajaxPrefilter (options, originalOptions, xhr) ->
  xhr.setRequestHeader('X-CSRF-Token', token)


Arc9Starter.ProjectSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs:
    # images: {deserialize: "records"}
    images: {embedded: "always"}

  # extractSingle: (store, type, payload, id) ->
  #   console.log "extract single"
  #   this._super.apply(this, arguments)
  # extractArray: (store, type, payload) ->
  #   console.log "extract array", arguments
  #   this._super.apply(this, arguments)

})
# Arc9Starter.ProjectSerializer = DS.RESTSerializer.extend

