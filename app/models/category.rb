class Category < Base

  validates :name, presence: true
  validates :slug, length: { minimum: 3 }
  validates :slug, uniqueness: true

  def slug_candidates
      [
        :name,
        [:name, :id]
      ]
  end

  def normalize_friendly_id(value)
    Pinyin.t(value).to_s.parameterize
  end

  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged


  before_validation :normalize_slug, on: :update

  def normalize_slug
    self.slug = normalize_friendly_id(name)
  end



  has_many :articles, inverse_of: :category

  default_scope { order("updated_at DESC") }

end