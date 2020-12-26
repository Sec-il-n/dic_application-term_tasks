class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  PAR = 10
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email])
    # user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      # 追記
      # TasksControllerに同じ処理　→concernで呼び出す。
      @tasks = Task.tasks_of_user(session[:user_id]).serch_valid_tasks
      # 種類の違うflashを複数表示することはできない。
      warning = check_valid(@tasks)
      if warning.present?
        # option:期限直近メール
        binding.pry
        ValidAnnounceMailer.valid_announce_mail(current_user).deliver
        # 一旦遷移
        redirect_to tasks_path, warning: t('dictionary.words.logged in') + warning
      else
        redirect_to tasks_path, notice: t('dictionary.words.logged in')
      end
    else
      # flash効かない
      # flash.now[:danger] = t('dictionary.words.login failed')
      render :new
    end
  end
  def index
    @tasks = Task.page(params[:page]).per(PAR)
    @tasks = @tasks.tasks_of_user(session[:user_id]).serch_valid_tasks
  end
  def destroy
    session.delete(:user_id)
    redirect_to new_session_path, notice: t('dictionary.words.logged out')
  end
  private
  def check_valid(tasks)
    if tasks.present?
      '終了期限間近、もしくは終了期限の切れたタスクがあります。'
      # flash[:worning] = '終了期限間近、もしくは終了期限の切れたタスクがあります。'
    end
  end
end
