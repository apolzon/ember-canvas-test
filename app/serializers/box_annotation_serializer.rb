class BoxAnnotationSerializer < ActiveModel::Serializer
  attributes :id, :x, :y, :width, :height, :image_id
  embed :ids, include: true

  def image_id
    object.image.id.to_s
  end
end