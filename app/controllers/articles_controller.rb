class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!
  
  def index

    respond_to do |format|

      if params["display"] == "mini"

        @articles = Article.with_volume(params["volume"])

        format.html { render :template => "articles/form_list.html.slim",:layout => false }
      
      else
        
        @articles = Article.preload(:category).page params[:page]
    
        format.html { render :template => "articles/index.html.slim" }

      end

    end
  end

  def new
    @article = Article.new
  end


  def show
  end

  def edit
  end


  def create
   
    if !article_params["image_file"].nil?

      image_file = article_params["image_file"] 

      @article = Article.new(article_params.reject! {| key, value | key == "image_file" })

      @article.update_image(image_file)
    
    else

      @article = Article.new(article_params)

    end

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

      if !article_params["image_file"].nil?

        @article.update_image(article_params["image_file"] )

        @article.image.save

        rst =  @article.update(article_params.reject! {| key, value | key == "image_file" })

        

      else

       rst =  @article.update(article_params)
     
      end

      if rst
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
      params.require(:article).permit(:title, :author, :editor, :source, :summary, :category_id, :volume, :image_file, {article_body_attributes: :body})
    end

end
