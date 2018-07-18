class ReservationsController < ApplicationController
  before_action :require_login

  def create
    if session[:reservation].nil?
      date_start = params[:reservations][:date_start].to_time
      date_end = params[:reservations][:date_end].to_time
      table_id = params[:reservations][:table_id]
      find_table_of_booking = Booking.find_by table_id: table_id
      if find_table_of_booking.present?
        date_start_of_booking = find_table_of_booking.time_start.to_time
        date_end_of_booking = find_table_of_booking.time_end.to_time
        if date_start > date_end_of_booking || date_start < date_start_of_booking
          session[:reservation] = {}
          session[:reservation].merge!({"table" => {"table_id" => params[:reservations][:table_id], "time_start" => date_start, "time_end" => date_end}})
          flash[:success] = t "home.reserved_table"
          redirect_to root_path
        else
            flash[:danger] = t "home.same_time"
            redirect_to root_path
        end
      else
        session[:reservation] = {}
        session[:reservation].merge!({"table" => {"table_id" => params[:reservations][:table_id], "time_start" => date_start, "time_end" => date_end}})
        flash[:success] = t "home.reserved_table"
        redirect_to root_path
      end
    else
      flash[:danger] = t "home.reserved_table_error"
      redirect_to root_path
    end
  end

  def destroy
    session.delete(:cart)
    session.delete(:reservation)
    flash[:success] = t "home.destroy_book"
    redirect_to root_path
  end
end
