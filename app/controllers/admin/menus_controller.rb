class Admin::MenusController < Admin::BaseController
  before_action :logged_in_user, :admin_user, :load_status_menu, :load_status
  before_action :load_menu, except: %i(index new create)
  before_action :load_dish, except: %i(index)

  def index
    @menus = Menu.search_by_type(params[:search])
      .filter_by_table(params[:table_id]).ordered.page(params[:page]).per Settings.settings.per_page
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new menu_params

    if @menu.save
      flash[:success] = t "admin.menu.create_success"
      redirect_to admin_menus_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @menu.update_attributes menu_params
      flash[:success] = t "admin.menu.update_success"
      redirect_to admin_menus_url
    else
      render :new
    end
  end

  private

  def menu_params
    params[:menu][:status] = params[:menu][:status].to_i
    params.require(:menu).permit :name, :status, dish_ids:[]
  end

  def load_menu
    @menu = Menu.find_by_id params[:id]
    return if @menu
      flash[:danger] = t "messages.not_foud_menu"
      redirect_to admin_menus_url
  end

  def load_status_menu
    @menu_status = Menu.statuses
  end

  def load_dish
    @dishes = Dish.all
  end

  def load_status
    @tables = Menu.all.map{|c| [c.status]}.uniq
  end
end
