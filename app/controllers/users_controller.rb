class UsersController < ApplicationController
  def create
    @user = ShowOffApi::UserService.new(user: user_permitted_params)
    @request = @user.signup
    if @request.last == 200
      flash[:notice] = "success"
      session[:user_data] = @request.first['data']
    else
      flash[:error] = "Error"
    end
    redirect_to root_path
  end

  private
    def user_permitted_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
