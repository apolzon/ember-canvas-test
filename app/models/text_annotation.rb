class TextAnnotation
  include Mongoid::Document

  field :body, type: String
  field :location, type: Point
  embedded_in :image
end