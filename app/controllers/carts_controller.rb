class CartsController < ApplicationController
  before_action :load_menu, :load_type_table, :dish_params_id

  def index; end

  def create
    if session[:reservation]
      respond_to do |format|
        session[:cart] = {} unless session[:cart]
        cart = session[:cart]
        cart[@id] = cart[@id] ? (cart[@id].to_i + 1) : 1
        session_cart
        @mess = t "home.order_dish_success"
        format.js {render "carts.js.erb"}
      end
    else
      respond_to do |format|
        format.html{
          flash[:warning] = t "home.require_booktable"
          redirect_to tables_path
        }
      end
    end
  end

  def update
    quantity = params[:quantity].to_i
    respond_to do |format|
      cart = session[:cart]
      cart[@id] = quantity
      session_cart
      @mess = t "success_update_cart"
      format.js {render "carts.js.erb"}
    end
  end

  def destroy
    respond_to do |format|
      cart = session[:cart]
      cart.delete(@id)
      session_cart
      @mess = t "success_delete_cart"
      format.js {render "carts.js.erb"}
    end
  end

  def dish_params_id
    @id = params[:id]
    @dish = Dish.find_by @id
    return if @dish
    flash[:danger] = t :not_found_dish
    redirect_to root_path
  end
end
