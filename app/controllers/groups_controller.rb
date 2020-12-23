class GroupsController < ApplicationController
  before_action :set_group, only:[:show, :edit, :destroy]
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group && @group.save
      redirect_to group_path(@group.id), notice: t('.groups.create.created')
    else
      render 'new'
    end

  end

  def index
    @groups = Group.all
    # @user_groups = UserGroup.where(user_id: current_user.id)
  end

  def edit
  end

  def show

  end

  def destroy
  end
  private
  def group_params
    params.require(:group).permit(:group_name).merge(admin_u_id: current_user.id)
  end
  def set_group
    @group = Group.find_by(id: params[:id])
  end
end
