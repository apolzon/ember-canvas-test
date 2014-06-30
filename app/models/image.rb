class Image
  include Mongoid::Document
  include Mongoid::Paperclip

  has_mongoid_attached_file :attachment,
    s3_credentials: {bucket: "arc9-starter-dev"}

  validates_attachment :attachment,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }


  field :file_url, type: String
  embeds_many :text_annotations
  embeds_many :box_annotations
  embedded_in :project

  def id
    self._id.to_s
  end
end