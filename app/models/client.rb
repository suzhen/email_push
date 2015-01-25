class Client < Base

  validates :name, presence: true

  validates :email, presence: true

  has_and_belongs_to_many :groups, join_table: :client_groups

  default_scope { order("updated_at DESC") }

end
