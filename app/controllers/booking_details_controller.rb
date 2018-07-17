class BookingDetailsController < ApplicationController
  def create
    if session[:reservation]
      dish = Dish.find_by id: params[:dish_id]
      unless session[:reservation]["detail"]
        session[:reservation][:detail] = {dish.id.to_s => {"dish_name": dish.name, "dish_price": dish.price, "quantity": Settings.dish.default_quantity}}
      else
        session[:reservation]["detail"].merge!({dish.id.to_s => {"dish_name": dish.name, "dish_price": dish.price, "quantity": Settings.dish.default_quantity}})
      end
      flash[:success] = t "home.order_dish_success"
      redirect_to carts_path
    else
      respond_to do |format|
        format.html{
          flash[:warning] = t "home.require_booktable"
          redirect_to tables_path
        }
      end
    end
  end
end
