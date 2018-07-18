class Supports::AdminSupport
  attr_reader :bill

  def initialize bill
    @bill = bill
  end

  def booking
    @booking ||= @bill.booking
  end

  def dish
    @dish ||= @bill.booking.booking_details
  end

  def category
    @category ||= Category.display.ordered
  end
end
