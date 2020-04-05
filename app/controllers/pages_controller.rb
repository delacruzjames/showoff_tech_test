class PagesController < ApplicationController
  def index
    @request = params[:search].present? ? widgets_with_term : widgets_without_term
    @widgets = @request.first['data']['widgets']
  end

  private
    def widgets_with_term
      @request = ShowOffApi::WidgetsService::Visible.index(params[:search])
    end

    def widgets_without_term
      @request = ShowOffApi::WidgetsService::Visible.index
    end
end
