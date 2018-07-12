class Supports::DishSupport
  attr_reader :dish

  def initialize dish
    @dish = dish
  end

  def comments
    @comment ||= @dish.reviews
  end

  def images
    @images ||= @dish.images
  end

  def category
    @category ||= Category.display.ordered
  end
end
