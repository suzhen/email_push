class Matrix < Base

  validates :name, presence: true

  validates :content, presence: true

  default_scope { order("updated_at DESC") }

  has_many :emails, inverse_of: :matrix

  has_many :images, as: :viewable, dependent: :destroy, class_name: "Image"


  def update_image(file)
    if file.is_a? ActionDispatch::Http::UploadedFile
      file_path = file.tempfile.path
    elsif file.is_a? Tempfile
      file_path = file.path
    elsif file.is_a? String
      # TODO: refine upload a image from a remote url.
      if File.exist?(file) || file.start_with?('http://')
        file_path = file
      end
      # file_path = file
      # file_path = 'http://' + file if !file.start_with?('http://')
    end
    # begin 
      _image_file = MiniMagick::Image.open(file_path)   
      image = images.new
      image.attachment_file_size = _image_file.size
      image.attachment_width = _image_file.dimensions[0]
      image.attachment_height = _image_file.dimensions[1]
      image.attachment_content_type = _image_file.mime_type
      image.attachment = _image_file     
    # rescue => e 
    # end      
   
  end
  
end