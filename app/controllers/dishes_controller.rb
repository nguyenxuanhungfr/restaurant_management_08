class DishesController < ApplicationController
  before_action :load_menu, :load_dish, :load_type_table

  def show
    @support = Supports::DishSupport.new @dish
    @review = Review.new
  end

  private

  def load_dish
    @dish = Dish.find_by_id params[:id]
    return if @dish
    flash[:danger] = t "messages.not_foud_dish"
    redirect_to root_path
  end
end
