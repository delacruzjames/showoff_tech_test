class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?

  def current_user
    @current_user ||= ShowOffApi::UserService.current_user(token: session[:token]) if session[:token].present?
  end

  def user_signed_in?
    current_user != nil
  end
end
