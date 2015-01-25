class GroupsController < ApplicationController

  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
  end

  def edit
  end


  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: '分组创建成功。' }
      else
        format.html { render :new }
      end
    end
  end


  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: '分组更新成功。' }
      else
        format.html { render :edit }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name)
    end


end
