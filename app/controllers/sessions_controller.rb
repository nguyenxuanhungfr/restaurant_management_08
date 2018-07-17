class SessionsController < ApplicationController
  before_action :load_menu, only: [:new, :destroy, :create]
  before_action :load_type_table

  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == Settings.settings.remember ? remember(user) : forget(user)
      flash[:success] = t "users.login_suceess"
      redirect_to root_url
    else
      flash.now[:danger] = t "users.invalid_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = t "users.logout_suceess"
    redirect_to root_url
  end
end
