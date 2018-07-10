class UsersController < ApplicationController
  before_action :load_menu, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t "flash.success_create_user"
      redirect_to root_url
    else
      render action: :new
    end
  end

  private

  def user_params
    params.require(:user).permit :email, :name, :address, :phone, :password,
      :password_confirmation
  end
end
