class Admin::PaymentsController < Admin::BaseController
  before_action :logged_in_user
  before_action :load_booking, except: %i(index new)

  def update
    time = Time.new.to_i
    code = t("bill") + time.to_s
    bill = Bill.new user_id: @booking.user_id, booking_id: @booking.id,
      total_amount: @booking.booking_details.sum("price * quantity"),
      code: code

    bill.transaction do
      if bill.save
        @booking.update_attributes status: Settings.settings.bill_success
        flash[:danger] = t "admin.bill.create_bill_success"
        redirect_to admin_bookings_url
      end
    end
  end

  private

  def load_booking
    @booking = Booking.find_by_id params[:id]
    return if @booking
    flash[:danger] = t "admin.booking.not_foud_booking"
    redirect_to admin_bookings_url
  end
end
