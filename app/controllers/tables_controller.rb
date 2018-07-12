class TablesController < ApplicationController
  before_action :load_menu, :load_type_table

  def index
    @tables = Table.search_by_number_of_people(params[:number]).search_by_type_table(params[:status]).ordered.page(params[:page]).per Settings.settings.per_page
    if params[:number].present?
      flash.now[:success] = t "home.find_success"
    end
  end

  def show
    @table = Table.find_by id: params[:id]
    return if @table
    flash[:danger] = t "admin.table.not_found_table"
    redirect_to root_url
  end
end
