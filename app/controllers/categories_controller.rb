class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end


  def show
    @articles = @category.articles
  end

  def edit
  end


  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: '栏目创建成功。' }
      else
        format.html { render :new }
      end
    end
    
  end


  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: '栏目创建成功。' }
      else
        format.html { render :edit }
      end
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find_by(:slug=>params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end

end
