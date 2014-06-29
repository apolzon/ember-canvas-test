class Image
  include Mongoid::Document

  field :file_url, type: String
  embedded_in :project
end