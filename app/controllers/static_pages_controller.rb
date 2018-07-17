class StaticPagesController < ApplicationController
  before_action :load_menu, only: :home
  before_action :load_type_table, :load_review

  def home
    @support = Supports::HomeSupport.new
    @dishes = Dish.ordered.limit Settings.settings.limit_dish_home
  end

  def load_category
    cate_id = params[:cate_id]
    if cate_id.blank?
      @list_dishes = Dish.ordered.limit Settings.settings.limit_dish_home
    else
      @list_dishes = Dish.ordered.where(category_id: cate_id).limit Settings.settings.limit_dish_home
    end
    respond_to do |format|
      format.js
    end
  end

  def load_dishes
    search = params[:search].delete("\t\r\n").strip
    @search_dishes = Dish.search_by_name(search) if search.present?
    respond_to do |format|
      format.js
    end
  end

  private

  def load_review
    @reviews = Review.list_review.limit Settings.settings.limit_review_home
  end
end
