class HistoriesController < ApplicationController
  before_action :load_menu, :correct_user
  before_action :find_params_id, only: :show
  before_action :check_view, only: :show
  before_action :load_menu, :load_type_table

  def index
    @history = current_user.bookings.search_by_type(params[:search])
  end

  def show
    @booking_detail = @booking.booking_details
  end

  private

  def find_params_id
    @booking = Booking.find_by_id params[:id]
    return if @booking
      flash[:danger] = t "cannot_find_booking"
      redirect_to root_url
  end

  def check_view
    redirect_to root_url unless current_user.id == @booking.user_id
  end

  def correct_user
    redirect_to root_url unless logged_in?
  end
end
