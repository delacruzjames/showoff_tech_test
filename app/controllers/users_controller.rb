class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:change_password, :me, :update]

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

  def update
    @request = ShowOffApi::UserService.update({user: user_permitted_params}, token: session[:token])

    if @request.status == 200
      flash[:success] = @request.message
    else
      flash[:error] = @request.message
    end
    redirect_to me_users_path
  end

  def me;end

  def change_password
    @request = ShowOffApi::UserService.change_password({user: user_permitted_params}, token: session[:token])

    if @request.status == 200
      flash[:success] = @request.message
      session[:token] = @request.token['access_token']
    else
      flash[:error] = @request.message
    end
    redirect_to me_users_path
  end

  def reset_password
    @request = ShowOffApi::UserService.reset_password({user: user_permitted_params}, {})
    if @request.status == 200
      session[:token] = nil
      flash[:success] = @request.message
    end
    redirect_to root_path
  end

  private
    def user_permitted_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :current_password,
        :new_password,
        :image_url,
        :date_of_birth
      )
    end
end
