class Admin::StaffsController < Admin::BaseController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @staffs = Staff.page(params[:page]).per Settings.settings.per_page
  end
end
