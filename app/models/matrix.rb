class Matrix < Base

  validates :name, presence: true

  validates :content, presence: true

  default_scope { order("updated_at DESC") }

  has_many :emails, inverse_of: :matrix
  
end