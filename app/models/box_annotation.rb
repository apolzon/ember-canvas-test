class BoxAnnotation
  include Mongoid::Document

  field :x, type: String
  field :y, type: String
  field :width, type: String
  field :height, type: String
  embedded_in :image

  def id
    self._id.to_s
  end
end