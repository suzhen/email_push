class Email < Base

  validates :subject, presence: true

  default_scope { order("updated_at DESC") }

  has_and_belongs_to_many :articles, join_table: :email_articles

  has_and_belongs_to_many :groups, join_table: :email_groups

  belongs_to :matrix, inverse_of: :emails

  def generate_content
    self.body = Liquid::Template.parse(self.matrix.content).render 'articles' => Article.find(self.articles.map(&:id))
  end

  before_save :generate_content

  def receivers
    groups.map(&:client_emails).flatten.uniq
  end

  def group_names
    groups.map(&:name).join(",")
  end

  def delivered?
    !!self.sent_at
  end

  def deliver
      EmailWorker.perform_async(self.id)
  end 





end
