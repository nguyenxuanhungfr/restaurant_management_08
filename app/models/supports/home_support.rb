class Supports::HomeSupport

  def dish_slibar
    @dish_slibar ||= Dish.ordered.limit Settings.settings.limit_dish_slibar
  end

  def category
    @category ||= Category.display.ordered.limit Settings.settings.limit_category_home
  end

  def total_order
    @total_orders ||=  Booking.total_order
  end

  def total_revenue
    @total_revenue = BookingDetail.total_revenue
  end

  def total_member
    @total_member = User.total_member
  end

  def total_booking
    @chart_data = Booking.number_of_orders_by_status
  end
end
