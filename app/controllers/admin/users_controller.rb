class Admin::UsersController < Admin::BaseController
  before_action :logged_in_user

  def index
    @users = User.page(params[:page]).per Settings.settings.per_page
  end
end
