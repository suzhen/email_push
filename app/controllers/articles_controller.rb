class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.preload(:category).all
  end

  def new
    @article = Article.new
  end


  def show
  end

  def edit
  end


  def create
    @article = Article.new(article_params)

    @article.article_body.body = article_params["article_body_attributes"]["body"]

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: '文章创建成功。' }
      else
        format.html { render :new }
      end
    end
    
  end


  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: '文章更新成功。' }
      else
        format.html { render :edit }
      end
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find_by(:slug=>params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :author, :editor, :source, :summary, :category_id, {article_body_attributes: :body})
    end

end
