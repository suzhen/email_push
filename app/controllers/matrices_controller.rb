class MatricesController < ApplicationController
  before_action :set_matrix, only: [:show, :edit, :update, :destroy]

  def index
    @matrices = Matrix.all
  end

  def show
    @images = @matrix.images
  end

  def new
    @matrix = Matrix.new
  end

  def edit
  end

  def create
    
    if !matrix_params["image_file"].nil?

      image_file = matrix_params["image_file"] 

      @matrix = Matrix.new(matrix_params.reject! {| key, value | key == "image_file" })

      @matrix.update_image(image_file)
    
    else

      @matrix = Matrix.new(matrix_params)

    end

    respond_to do |format|
      if @matrix.save
        format.html { redirect_to @matrix, notice: '模版创建成功。' }
      else
        format.html { render :new }
      end
    end

  end

  def update
    if !matrix_params["image_file"].nil?

        @matrix.update_image(matrix_params["image_file"] )

        rst =  @matrix.update(matrix_params.reject! {| key, value | key == "image_file" })

    else

       rst =  @matrix.update(matrix_params)
     
    end

    respond_to do |format|
      if rst
        format.html { redirect_to @matrix, notice: '模版更新成功' }
      else
        format.html { render :edit }
      end
    end
  end

  # def destroy
  #   @matrix.destroy
  #   respond_to do |format|
  #     format.html { redirect_to matrices_url, notice: 'Matrix was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_matrix
      @matrix = Matrix.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def matrix_params
       params.require(:matrix).permit(:name,:content,:image_file)
    end
end
