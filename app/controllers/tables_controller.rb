class TablesController < ApplicationController
  before_action :load_menu

  def index
    @tables = Table.ordered.page(params[:page]).per Settings.settings.per_page
  end

  def show
    @table = Table.find_by id: params[:id]
    return if @table
    flash[:danger] = t "admin.table.not_found_table"
    redirect_to root_url
  end
end
