class StaticPagesController < ApplicationController
  before_action :load_menu

  def home
    @support = Supports::DishSupport.new
  end
end
