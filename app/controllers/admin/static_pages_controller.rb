class Admin::StaticPagesController < Admin::BaseController
  before_action :logged_in_user

  def home
    @total_orders = Booking.count('id')
    @total_revenue = BookingDetail.all.sum('price*quantity')
    @total_member = User.count('id');
  end
end
