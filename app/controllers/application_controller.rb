class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def authenticate_with_basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      @current_user = User.authenticated?(username, password)
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

end
