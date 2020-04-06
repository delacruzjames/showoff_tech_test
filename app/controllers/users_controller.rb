class UsersController < ApplicationController
  def create
    user_params = { client_id: ENV['CLIENT_ID'], client_secret: ENV['CLIENT_SECRET'], user: user_permitted_params }
    @request = ShowOffApi::UserService.signup(user_params)

    if @request.last == 200
      flash[:notice] = "success"
    else
      flash[:alert] = "Error"
    end
    redirect_to root_path
  end

  private
    def user_permitted_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
