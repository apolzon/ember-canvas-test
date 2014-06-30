class BoxAnnotation
  include Mongoid::Document

  field :location, type: Point
  embedded_in :image
end