module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user? user
    user == current_user
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by id: user_id
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by id: user_id
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def logged_in?
    current_user ? true : false
  end

  def log_out
    forget current_user
    session.delete :user_id
    session.delete :reservation
    @current_user = nil
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def redirect_back_or default
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end

  def log_in_admin admin
    session[:admin_id] = admin.id
  end

  def current_admin? admin
    admin == current_admin
  end

  def current_admin
    if admin_id = session[:admin_id]
      @current_admin ||= Staff.find_by id: admin_id
    elsif admin_id = cookies.signed[:admin_id]
      admin = Staff.find_by id: admin_id
      if admin && admin.authenticated?(cookies[:remember_token])
        log_in admin
        @current_admin = admin
      end
    end
  end

  def correct_admin? admin
    admin == t("admin.staff.role_admin")
  end

  def remember_admin admin
    admin.remember_admin
    cookies.permanent.signed[:admin_id] = admin.id
    cookies.permanent[:remember_token] = admin.remember_token
  end

  def logged_in_admin?
    current_admin ? true : false
  end

  def log_out_admin
    session.delete :admin_id
    @current_admin = nil
  end
end
