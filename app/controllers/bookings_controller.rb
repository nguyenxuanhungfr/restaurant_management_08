class BookingsController < ApplicationController
  before_action :load_menu, :load_type_table
  before_action :check_cart, only: :new

  def new
    @booking = current_user.bookings.new
  end

  def create
    @booking = current_user.bookings.build booking_params
    @booking.status = :pending
    if @booking.save
      session.delete :reservation
      session.delete :cart
      UserMailer.user_mail(current_user, @booking).deliver_now
      flash[:success] = t "home.order_success"
      redirect_to tables_path
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:time_start, :time_end, :table_id, :name,
      :email, :address, :phone, booking_details_attributes: [:id, :quantity, :price, :booking_id, :dish_id])
  end

  def check_cart
    if session[:reservation].nil?
      flash[:info] = t "home.require_booktable"
      redirect_to tables_path
    elsif session[:cart].nil?
      flash[:info] = t "home.cart_nil"
      redirect_to root_path
    end
  end
end
