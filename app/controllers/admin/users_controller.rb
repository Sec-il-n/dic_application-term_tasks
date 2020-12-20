class Admin::UsersController < ApplicationController
  before_action :admin_user, :set_user
  def new
    @user = User.new
  end
  def create
    @user = User.new(params_admin_user)
    if @user.save
      redirect_to admin_user_path(@user.id), notice: t('admin.users.show.user add successed')
    else
      # バリデーションでもこのメッセージが出てしまう。（保留）
      # flash.now[:danger] = t('admin.users.form.user add failed')
      render 'new'
    end
  end
  def index
    # binding.pry
    @users = User.includes(:tasks)
    # @users = User.all
  end
  def show
    @tasks = @user.tasks
  end
  def edit

  end
  def update
    # binding.pry
      if @user.update(params_admin_user)

        redirect_to admin_users_path, notice: t('admin.users.index.editted user')
      else
        render 'edit'
      end
  end
  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: t('admin.users.index.user deleted')
    else
      flash[:warning] = t('dictionary.words.admin needs minimum one')
    end
  end
  private
  def admin_user
    if current_user.admin == false
      redirect_to tasks_path, danger: t('admin.users.index.need loggedin')
    end
  end
  def set_user
    @user = User.find_by(id: params[:id])
  end
  def params_admin_user
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :admin)
    # params.permit(:id, user: :admin)
    # params.permit(:id, :_method, :authenticity_token, { user: :admin } )
    # id, :_method, :authenticity_token => は許可しないとパラメタで受け取れないし、User.update(ここ)で使用すると「Userの属性ではない」と怒られる。　＝＞　StrongParametersは使えないのか？？
    # binding.pry
    # params.permit(:id, :user_name, :email, :password, :password_confirmation, :admin)
  end
end
