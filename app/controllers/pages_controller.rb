class PagesController < ApplicationController
  def index
    @widgets = params[:search].present? ? widgets_with_term : widgets_without_term
  end

  private
    def widgets_with_term
      ShowOffApi::WidgetService.index(params[:search])
    end

    def widgets_without_term
      ShowOffApi::WidgetService.index
    end
end
