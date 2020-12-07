module SessionsHelper
  def logged_in?
    current_user.present?
  end
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    # @current_user ||= User.find(session[:user_id])
  end
end
