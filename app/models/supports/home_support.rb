class Supports::HomeSupport

  def dish_slibar
    @dish_slibar ||= Dish.ordered.limit Settings.settings.limit_dish_slibar
  end

  def category
    @category ||= Category.display.ordered.limit Settings.settings.limit_category_home
  end
end
