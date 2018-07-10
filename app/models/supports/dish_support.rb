class Supports::DishSupport
  attr_reader :dish

  def dish_slibar
    @dish_slibar ||= Dish.ordered.limit Settings.settings.limit_dish_slibar
  end
end
