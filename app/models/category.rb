class Category < Base

  validates :name, presence: true

  has_many :articles, inverse_of: :category

  default_scope { order("updated_at DESC") }

end