class SessionsController < ApplicationController
  def create
    login_params = {
      grant_type: 'password',
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      username: params['username'],
      password: params['password']
    }
    @request = ShowOffApi::UserService.login(login_params)

    if @request.last == 200
      session[:access_token] =  @request.first['data']['token']['access_token']
      session[:refresh_token] =  @request.first['data']['token']['refresh_token']
      flash[:notice] = "Successfully login"
      redirect_to dashboard_path
    else
      flash[:error] = "#{@request.first['message']}"
      redirect_to root_path
    end
  end

  def destroy
    session[:access_token] = nil
    flash[:notice] = "Successfully logout"
    redirect_to root_path
  end
end
