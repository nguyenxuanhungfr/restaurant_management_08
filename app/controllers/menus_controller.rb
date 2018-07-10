class MenusController < ApplicationController
  before_action :load_menu, :load_menu_by_id

  def show
    @dishes = @menu_data.dishes.ordered
  end

  private

  def load_menu_by_id
    @menu_data = Menu.find_by_id params[:id]
    return if @menu_data
    flash[:danger] = t "messages.not_foud_menu"
    redirect_to root_path
  end
end
