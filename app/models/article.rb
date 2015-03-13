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
