class Image < Asset

  belongs_to :article,inverse_of: :image,touch:true

  belongs_to :matrix,inverse_of: :images,touch:true

  attr_accessor :uploader_secure_token

  mount_uploader :attachment, ImageUploader

  after_save :find_image_attributes

  def find_image_attributes
    self.update_column :attachment_url,attachment.url
  end

end