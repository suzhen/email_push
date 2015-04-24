class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!
  
  def index
    if params['keys'].present?
      @clients = Client.in_name_or_email_or_company_or_mobile(params['keys']).preload(:groups).page params[:page]
    else
      @clients = Client.preload(:groups).page params[:page]
    end  
  end

  def show
  end

  def edit
    # session["client_refere"] = request.referer if request.referer != request.original_url

    # puts "***"
    # puts session["client_refere"]
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
        format.html { redirect_to @client, notice: '客户更新成功。'}
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: '客户删除成功。' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :email, :tel, :mobile, :address, :company,:title,:postcode,:tag_list,:group_ids=>[])
    end

end
