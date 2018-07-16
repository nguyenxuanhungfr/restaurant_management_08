class Admin::TablesController < Admin::BaseController
  before_action :logged_in_user, :load_type_table, :admin_user
  before_action :load_table, except: %i(index new create)

  def index
    @tables = Table.ordered.page(params[:page]).per Settings.settings.per_page
  end

  def new
    @table = Table.new
  end

  def create
    @table = Table.new table_params

    if @table.save
      flash[:success] = t "create_success"
      redirect_to admin_tables_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @table.update_attributes table_params
      flash[:success] = t "create_success"
      redirect_to admin_tables_url
    else
      render :new
    end
  end

  private

  def load_table
    @table = Table.find_by_id params[:id]
    return if @table
      flash[:danger] = t "messages.not_foud_table"
      redirect_to admin_tables_url
  end

  def load_type_table
    @type_tables = Table.type_tables
  end

  def table_params
    params[:table][:type_table] = params[:table][:type_table].to_i
    params.require(:table).permit :name, :type_table, :number_of_people, :description,
      images_attributes: [:id, :url, :_destroy]
  end
end
