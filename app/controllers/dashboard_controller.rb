class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @request = ShowOffApi::WidgetService.index(session[:access_token])
    @widgets = @request.first['data']['widgets']
  end


  private
    def authenticate_user!
      unless user_signed_in?
        flash[:error] = "You need to login to the system"
        redirect_to root_path
      end
    end
end
