class GroupsController < ApplicationController
  before_action :set_group, only:[:show, :edit, :destroy]
  def new
    @group = Group.new
    # @group.groups.build
    @group.user_groups.build
  end

  def create
    @group = Group.new(group_params)
    if @group && @group.save
      redirect_to group_path(@group.id), notice: t('.created')
    else
      render 'new'
    end
  end

  def index
    @groups = Group.all
    # @user_groups = UserGroup.where(user_id: current_user.id)
  end

  def edit
    unless check_admin?(@group)
      redirect_to groups_path, danger: t('.cannot edit')
    end
  end

  def show

  end

  def destroy
    if check_admin?(@group) && @group.destroy && @group.user_groups.destroy_all
    # if @group.destroy && @group.user_groups.destroy_all
      redirect_to groups_path, notice: t('.group deleted')
    else
      redirect_to groups_path, danger: t('.cannot delete')
    end
  end
  private
  def group_params
    params.require(:group).permit(:group_name, user_groups_attributes:[:user_id, :group_id]) .merge(admin_user_id: current_user.id)
  end
  def set_group
    @group = Group.find_by(id: params[:id])
  end
  def check_admin?(group)
     group.admin_user_id == current_user.id
  end
end
