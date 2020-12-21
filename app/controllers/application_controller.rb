class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :basic_auth, if: :production?
  before_action :authenticate_user
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger
  private
  def production?
    Rails.env.production?
  end
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username = ENV['BASIC_AUTH_USER'] && password = ENV['BASIC_AUTH_PASSWORD']
    end
  end
  def authenticate_user
    if current_user == nil
      redirect_to new_session_path, notice: t('.need loggedin')
    end
  end
end
