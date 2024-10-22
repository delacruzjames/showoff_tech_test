class PagesController < ApplicationController
  def index
    redirect_to dashboard_path if user_signed_in?
    @widgets = params[:search].present? ? widgets_with_term : widgets_without_term
  end

  private

    def widgets_with_term
      ShowOffApi::WidgetService.visible(params[:search]).widgets
    end

    def widgets_without_term
      ShowOffApi::WidgetService.visible.widgets
    end
end
