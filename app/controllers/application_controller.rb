class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  include SessionsHelper

  def require_login
    return if logged_in?
    flash[:danger] = t "please_login"
    redirect_to login_path
  end

  def load_type_table
    @type_tables = Table.all.map{|c| c.type_table}.uniq
  end
end
