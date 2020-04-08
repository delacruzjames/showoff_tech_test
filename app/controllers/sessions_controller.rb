class SessionsController < ApplicationController
  def create
    @session = ShowOffApi::AuthenticateService.login(user_permitted_params)
    if @session.status == 200
      flash[:notice] = @session.message
      session[:token] = @session.token['access_token']
      redirect_to dashboard_path
    else
      flash[:error] = @session.message
      redirect_to root_path
    end
  end

  def destroy
    session[:token] = nil
    flash[:notice] = "Successfully logout"
    redirect_to root_path
  end

  private
    def user_permitted_params
      params.require(:user).permit(:username, :password)
    end
end
