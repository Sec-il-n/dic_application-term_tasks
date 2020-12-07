class UsersController < ApplicationController
  before_action :set_user
  def new
    @user = User.new
  end
  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to user_path#＋ログイン状態にする
      # redirect_to tasks_path
    else
      # flash.now[:danger] = 'ユーザー登録に失敗しました。'
      render :new
    end
  end
  def show
    # binding.pry
  end
  def edit

  end
  def update
    # @user = User.update(user_params)
    if @user.update(user_params)
      redirect_to(tasks_path, notice: 'ユーザー情報を編集しました。')
    else
      render :edit
    end
  end
  private
  def user_params
    params.require(:user).permit(:user_name, :email, :password)
  end
  def set_user
    @user = User.find_by(id: params[:id])
  end
end
