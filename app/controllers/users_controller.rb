class UsersController < ApplicationController
  def create
    @user = ShowOffApi::UserService.new(user: user_permitted_params)
    @request = @user.signup
    if @request.last == 200
      flash[:notice] = "success"
      session[:access_token] = @request.first['data']['token']['access_token']
      redirect_to dashboard_path
    else
      flash[:error] = "Error"
      redirect_to root_path
    end
  end

  private
    def user_permitted_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
