class BookingsController < ApplicationController
  before_action :load_menu, :load_type_table, :cart_user
  before_action :check_cart, only: :new

  def new
    @booking = current_user.bookings.new
  end

  def create
    @booking = current_user.bookings.build booking_params
    @booking.status = :pending
    if @booking.save
      @quantity_dish.each do |dish, quantity|
        @booking_details = @booking.booking_details.new quantity: quantity,
          dish_id: dish.id, price: dish.price
        @booking_details.transaction do
          raise t "error_order" unless @booking_details.save
        end
      end
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
      :email, :address, :phone)
  end

  def cart_user
    @cart = session[:cart] ? session[:cart] : Hash.new
    @quantity_dish = @cart.map {|id, quantity| [Dish.find_by(id: id), quantity]}

    if session[:cart].blank?
      flash[:danger] = t :need_login_checkout
      redirect_to root_url
    end
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
