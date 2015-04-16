class Email < Base

  validates :subject, presence: true

  default_scope { order("updated_at DESC") }

  has_and_belongs_to_many :articles, join_table: :email_articles

  has_and_belongs_to_many :groups, join_table: :email_groups

  belongs_to :matrix, inverse_of: :emails

  def generate_content
    category_hash = Hash[Category.all.map{|category| [category.slug,category.name]}]

    
    articles_hash = {}

    articles = Article.find(self.articles.map(&:id))

    articles.each do |article|

      category_slug = "#{article.category.slug}_articles"

      if articles_hash[category_slug].nil? 

        articles_hash[category_slug] = []

      end

      articles_hash[category_slug] << article

    end

    self.body = Liquid::Template.parse(self.matrix.content).render articles_hash.merge(category_hash)
  end

  before_create :generate_content

  def receivers
    groups.map(&:client_emails).flatten.uniq.reject{|email| email.blank? }
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
