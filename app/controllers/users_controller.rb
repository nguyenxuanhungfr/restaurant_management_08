class UsersController < ApplicationController
  before_action :load_menu
  before_action :logged_in_user, only: [:edit, :update]
  before_action :load_type_table, :correct_user

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

  def edit; end

  def update

    if @user.update_attributes user_params
      flash[:success] = t "update_user_sucess"
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def correct_user
    @user = User.find_by_id params[:id]
    redirect_to root_url unless @user == current_user
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = t "please_login"
      redirect_to login_url
    end
  end

  def user_params
    params.require(:user).permit :email, :name, :image, :address, :phone, :password,
      :password_confirmation
  end
end
