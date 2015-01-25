class ArticleBody < Base

  #validates :body, presence: true

  belongs_to :article, inverse_of: :article_body ,touch: true

end
