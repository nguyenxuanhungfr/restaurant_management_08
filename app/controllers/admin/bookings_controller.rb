class Admin::BookingsController < Admin::BaseController
  before_action :logged_in_user

  def index
    @bookings = Booking.search_by_type(params[:search]).page(params[:page]).per Settings.settings.per_page
  end
end
