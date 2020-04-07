class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_user, :user_signed_in?

  def current_user
    @current_user ||= ShowOffApi::UserService.current_user(token: session[:token]) if session[:token].present?
  end

  def user_signed_in?
    current_user != nil
  end

  private
  def authenticate_user!
    unless user_signed_in?
      flash[:error] = "Your session has expired. Please login again to continue."
      redirect_to root_path
    end
  end
end
