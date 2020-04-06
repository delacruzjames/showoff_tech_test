class DashboardController < ApplicationController
  def index
    unless user_signed_in?
      flash[:error] = "You need to login to the system"
      redirect_to root_path
    end
  end
end
