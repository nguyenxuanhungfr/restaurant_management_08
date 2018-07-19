class Admin::BookingsController < Admin::BaseController
  before_action :logged_in_user, :booking_status, :load_table
  before_action :load_booking, except: %i(index new create)

  def index
    @bookings = Booking.search_by_type(params[:search])
      .filter_by_table(params[:table_id])
      .page(params[:page]).per Settings.settings.per_page
    if params[:table_id].present? || params[:search].present?
      flash.now[:success] = t "admin.dish.search_success"
    end
  end

  def edit
    @dishes = Dish.ordered
  end

  def update
    if @booking.update_attributes booking_params
      flash[:success] = t "admin.booking.update_success"
      redirect_to admin_bookings_url
    else
      render :new
    end
  end

  private

  def booking_params
    params[:booking][:status] = params[:booking][:status].to_i
    params.require(:booking).permit :table_id, :status, :name, :address,
      :phone
  end

  def booking_status
    @booking_status = Booking.statuses
  end

  def load_booking
    @booking = Booking.find_by_id params[:id]
    return if @booking
    flash[:danger] = t "admin.booking.not_foud_booking"
    redirect_to admin_bookings_url
  end

  def load_table
    @tables = Booking.all.map{|c| [c.status]}.uniq
  end
end
