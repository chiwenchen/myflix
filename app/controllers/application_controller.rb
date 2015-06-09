class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    access_denied if !logged_in?
  end

  def access_denied
    flash[:danger] = 'You need to register or sign in to continue access'
    redirect_to front_path
  end

end
