class TablesController < ApplicationController
  before_action :load_menu

  def index
    @tables = Table.ordered.page(params[:page]).per Settings.settings.per_page
  end
end
