class TextAnnotation
  include Mongoid::Document

  field :body, type: String
  field :x, type: String
  field :y, type: String
  embedded_in :image
end