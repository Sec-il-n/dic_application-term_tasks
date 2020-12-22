class UsersController < ApplicationController
  before_action :set_user
  skip_before_action :authenticate_user
  def new
    @user = User.new
    if logged_in?
      redirect_to tasks_path, notice: t('dictionary.words.cannot create user')
    end
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: t('dictionary.words.user created')
    else
      # flash.now[:danger] = 'ユーザー登録に失敗しました。'
      render :new
    end
  end
  def show
    if current_user.id != params[:id].to_i
      redirect_to tasks_path, notice: t('dictionary.words.cannot see other details')
    end
  end
  def edit

  end
  def update
    if @user.update(user_params)
      redirect_to(tasks_path, notice: t('tasks.index.editted'))
    else
      render :edit
    end
  end
  private
  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end
  def set_user
    @user = User.find_by(id: params[:id])
  end
end
