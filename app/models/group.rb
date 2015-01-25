class Group < Base

  has_and_belongs_to_many :clients, join_table: :client_groups

  has_and_belongs_to_many :emails, join_table: :email_groups

  validates :name, presence: true, uniqueness: true

  def client_emails
    self.clients.map(&:email)
  end

  default_scope { order("updated_at DESC") }
  
end
