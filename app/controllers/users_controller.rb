class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:change_password, :me, :update, :refresh_token]

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
      session[:rf_token] = @request.token['refresh_token']
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

  def refresh_token
    params[:refresh_token] = session[:rf_token]
    @request = ShowOffApi::AuthenticateService.refresh_token(params, token: session[:token])

    if @request.status == 200
      flash[:success] = @request.message
      # respond_to do |format|
      #   format.html do
      #     flash[:success] = @request.message
      #   end
      #   format.js
      # end
    else
      flash[:error] = @request.message
    end
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
