class ImageSerializer < ActiveModel::Serializer
  attributes :id, :url, :project_id
  embed :ids, include: true

  def url
    object.attachment.url
  end

  def project_id
    object.project.id.to_s
  end
end