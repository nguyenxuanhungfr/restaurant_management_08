class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  include SessionsHelper
  before_action :session_cart

  def require_login
    return if logged_in?
    store_location
    flash[:danger] = t "please_login"
    redirect_to login_path
  end

  def load_type_table
    @type_tables = Table.all.map{|c| c.type_table}.uniq
  end

  def session_cart
    @cart = session[:cart] || {}
    @count_dish_cart = 0
    unless @cart.empty?
      @dishes_cart = @cart.map {|id, quantity| [Dish.find_by(id: id), quantity]}
      @count_dish_cart = @cart.length
      @total = total_cart @dishes_cart
    else
      @count_dish_cart = 0
    end
  end
end
