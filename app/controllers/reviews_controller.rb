class ReviewsController < ApplicationController
  before_action :load_menu, :load_dish, :load_type_table, :require_login

  def create
    review = current_user.reviews.build review_params

    respond_to do |format|
      flash.now[:status] = review.save
      @support = Supports::DishSupport.new @dish
      point = review.point + @dish.average_point
      @dish.rating point
      format.js
    end
  end

  private

  def review_params
    params.require(:review).permit :dish_id, :comment, :point
  end

  def load_dish
    @dish = Dish.find_by id: params[:review][:dish_id]
    return if @dish
    flash[:danger] = t "messages.not_foud_dish"
    redirect_to root_path
  end
end
