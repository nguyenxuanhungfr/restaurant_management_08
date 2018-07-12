class Admin::MenusController < Admin::BaseController
  before_action :logged_in_user, :admin_user

  def index
    @menus = Menu.ordered.page(params[:page]).per Settings.settings.per_page
  end
end
