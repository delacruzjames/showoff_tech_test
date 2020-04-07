class DashboardController < ApplicationController
  def index
    @widgets = params[:search].present? ? with_term : without_term
  end

  def me

  end


  private
    def with_term
      ShowOffApi::WidgetService.index({term: params[:search]}, token: session[:token])
    end

    def without_term
      ShowOffApi::WidgetService.index({}, token: session[:token])
    end
end
