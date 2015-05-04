class EmailsController < ApplicationController

  before_action :set_email, only: [:show, :edit, :update, :destroy, :deliver,:content]


  before_filter :authenticate_user!
  
  def index
    @emails = Email.all
  end

  def new
    @email = Email.new
  end

  def show
  end

  def edit
  end

  def content
    render :layout => false
  end

  def create
    @email = Email.new(email_params)
    
    respond_to do |format|
      if @email.save
        format.html { redirect_to @email, notice: '邮件创建成功。' }
      else
        format.html { render :new }
      end
    end
  end


  def destroy
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_url, notice: '邮件删除成功。' }
      format.json { head :no_content }
    end
  end




  def update
    respond_to do |format|
      if @email.update(email_params)
        format.html { redirect_to @email, notice: '邮件更新成功。' }
      else
        format.html { render :edit }
      end
    end
  end

  def deliver
  
    @email.update_attribute(:sent_at,Time.now)

    @email.deliver

    render :text=>"ok"
  
  end



   private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_params
      params.require(:email).permit(:subject,:body, :matrix_id, :article_ids=>[],:group_ids=>[])
    end


end
