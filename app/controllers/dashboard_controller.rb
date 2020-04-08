class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @widgets = params[:search].present? ? with_term : without_term
  end

  def me

  end


  private
    def with_term
      ShowOffApi::WidgetService.index(params[:search], token: session[:token]).widgets
    end

    def without_term
      ShowOffApi::WidgetService.index(token: session[:token]).widgets
    end
end
