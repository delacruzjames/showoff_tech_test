class WidgetsController < ApplicationController
  def create
    @widget = ShowOffApi::WidgetService.save(widget_permitted_params, token: session[:token])

    if @widget[:status] == 200
      flash[:success] = @widget[:message]
    else
      flash[:error] = @widget[:message]
    end
    redirect_to dashboard_path
  end

  private
    def widget_permitted_params
      params.require(:widget).permit(:name, :description, :kind)
    end
end
