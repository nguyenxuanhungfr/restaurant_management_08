class Admin::SessionsController < Admin::BaseController
  layout "admin/layouts/application"
  def new
    return unless logged_in_admin?
    flash[:info] = t "logged_in"
    redirect_to admin_root_url
  end

  def create
    admin = Staff.find_by email: params[:session][:email].downcase
    if admin && admin.authenticate(params[:session][:password]) && admin.role == Settings.setting_model.role_admin
      log_in_admin admin
      redirect_back_or admin_root_url
    else
      flash.now[:danger] = t "users.invalid_login"
      render :new
    end
  end

  def destroy
    log_out_admin if logged_in_admin?
    redirect_to admin_root_url
  end
end
