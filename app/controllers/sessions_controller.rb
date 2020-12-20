class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to tasks_path, notice: t('dictionary.words.logged in')
    else
      render :new
    end
  end
  def destroy
    session.delete(:user_id)
    redirect_to new_session_path, notice: t('dictionary.words.logged out')
  end
end
