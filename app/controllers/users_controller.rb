class UsersController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = ShowOffApi::UserService.create(user: user_permitted_params)
    if @user.status == 200
      session[:token] = @user.token['access_token']
      flash[:success] = @user.message
    else
      flash[:error] = @user.message
    end
    redirect_to root_path
  end

  def me

  end

  private
    def user_permitted_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
