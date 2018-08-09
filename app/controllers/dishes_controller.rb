class DishesController < ApplicationController
  before_action :load_menu, :load_type_table
  before_action :load_dish, only: [:show]

  def index
    @dishes = Dish.page(params[:page]).search(params[:search]).per Settings.settings.page_all_dish
  end

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
