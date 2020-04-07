class WidgetsController < ApplicationController
  def create
    @widget = ShowOffApi::WidgetService.save(widget_permitted_params, token: session[:token])
    @widget[:status] == 200 ? flash[:success] = @widget[:message] : flash[:error] = @widget[:message]
    redirect_to dashboard_path
  end

  def update
    widget_params = {widget: widget_permitted_params}
    @widget = ShowOffApi::WidgetService.update(widget_permitted_params['id'],widget_params,token: session[:token])
    @widget[:status] == 200 ? flash[:success] = @widget[:message] : flash[:error] = @widget[:message]
    redirect_to dashboard_path
  end

  private
    def widget_permitted_params
      params.require(:widget).permit(:id, :name, :description, :kind)
    end
end
