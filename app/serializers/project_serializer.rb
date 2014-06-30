class ProjectSerializer < ActiveModel::Serializer
  attributes :name, :id
  embed :ids, include: true
  has_many :images, serializer: ImageSerializer, key: :image_ids, root: :image, embed_key: :id

  def id
    object._id.to_s
  end

end