class Article < Base
  
  has_one :article_body , inverse_of: :article, autosave: true,dependent: :destroy

  belongs_to :category, inverse_of: :articles,touch: true

  validates :title, presence: true
  validates :slug, length: { minimum: 3 }
  validates :slug, uniqueness: true

  delegate :body, :formatted_html, :caption, :short_caption , to: :article_body 

  accepts_nested_attributes_for :article_body, allow_destroy: true

  # add and update friendly_id

  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
      [
        :title,
        [:title, :id]
      ]
  end

  def normalize_friendly_id(value)
    Pinyin.t(value).to_s.parameterize
  end

  before_validation :normalize_slug, on: :update

  def normalize_slug
    self.slug = normalize_friendly_id(title)
  end

  after_destroy :punch_slug

  def punch_slug
      update_column :slug, "#{Time.now.to_i}_#{slug}" # punch slug with date prefix to allow reuse of original
  end

  # soft deleted

  acts_as_paranoid

  def deleted?
    !!deleted_at
  end

  after_initialize :ensure_body

  default_scope { order("updated_at DESC") }


  has_one :image, as: :viewable, dependent: :destroy, class_name: "Image"

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
      image.attachment_file_size = _image_file.size
      image.attachment_width = _image_file.dimensions[0]
      image.attachment_height = _image_file.dimensions[1]
      image.attachment_content_type = _image_file.mime_type
      image.attachment = _image_file     
    # rescue => e 
    # end      
    image
  end

  after_initialize :ensure_attachment

  def ensure_attachment
      return unless new_record?
      self.image ||= Image.new
  end

  def to_liquid
    {
     'title'=>self.title,
     'formatted_html'=>self.body 
    }
  end

  private

    def ensure_body
      return unless new_record?
      self.article_body ||= ArticleBody.new
      self.article_body.body = ""
    end

end
