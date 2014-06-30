class ImageSerializer < ActiveModel::Serializer
  attributes :id, :url, :project_id
  embed :ids, include: true
  has_many :box_annotations, serializer: BoxAnnotationSerializer, key: :box_annotation_ids, root: :box_annotation, embed_key: :id

  def url
    object.attachment.url
  end

  def project_id
    object.project.id.to_s
  end
end