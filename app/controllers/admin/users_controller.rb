class Admin::UsersController < ApplicationController
  before_action :admin_user, :set_user
  def new
  end
  def index
    @users = User.all
  end
  def show
    binding.pry
    @tasks = @user.tasks
  end
  def edit

  end
  def update

  end
  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: t('dictionary.words.user deleted')
  end
  private
  def admin_user
    redirect_to tasks_path if current_user.admin = false
  end
  def set_user
    @user = User.find_by(id: params[:id])
  end
end
