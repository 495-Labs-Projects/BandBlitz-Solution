class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, :notice => 'User was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user, :notice => 'User was successfully updated.'
    else
      render :action => "edit"
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :role, :password, :password_confirmation, :band_id, :active)
    end
end