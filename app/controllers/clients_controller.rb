class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all.order("updated_at desc")
  end

  def show
  end

  def edit
  end


  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: '客户创建成功。' }
      else
        format.html { render :new }
      end
    end
  end


  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: '客户更新成功。' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /matrices/1
  # DELETE /matrices/1.json
  # def destroy
  #   @matrix.destroy
  #   respond_to do |format|
  #     format.html { redirect_to matrices_url, notice: 'Matrix was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :email, :tel, :mobile, :address, :group_ids=>[])
    end

end
