class UserGroupsController < ApplicationController
  def create
    group_joined = current_user.user_groups.create(group_id: params[:group_id])
    redirect_to groups_path, notice: 'グループに参加しました。'
    # redirect_to groups_path, notice: t('.joined')
    # translation missing: ja.user_groups.create.joined
  end
  def index
  end
  def destroy
    binding.pry
    user_group = current_user.user_groups.find_by(group_id: params[:id]).destroy
    # if current_user.groups.find_by(id: params[:group_id]).destroy
    if user_group.present?
      redirect_to groups_path, notice: 'グループから離脱しました。'
    else
      redirect_to groups_path, warning: 'グループから離脱できません。'
    end
  end
  private
  def user_groups_params
    params.require(:user_groups).permit(group_id: params[:group_id]).merge(user_id: current_user.id)
  end
end
