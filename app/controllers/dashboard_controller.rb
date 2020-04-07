class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # @request = ShowOffApi::WidgetService.index(session[:access_token])
    # @widgets = @request.first['data']['widgets']
    @widgets = []
  end

  def me

  end


  private
    def authenticate_user!
      unless user_signed_in?
        flash[:error] = "Your session has expired. Please login again to continue."
        redirect_to root_path
      end
    end
end
