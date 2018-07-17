class Admin::DishesController < Admin::BaseController
  before_action :logged_in_user, :load_status_dish, :map_category
  before_action :load_dish, except: %i(index new create)

  def index
    @dishes = Dish.ordered.filter_by_category(params[:category_id])
      .filter_by_status(params[:status]).search(params[:search])
      .page(params[:page]).per Settings.settings.per_page

    if params[:category_id].present? || params[:status].present? || params[:search].present?
      flash.now[:success] = t "admin.dish.search_success"
    end
  end

  def new
    @dish = Dish.new
  end

  def create
    @dish = Dish.new dish_params

    if @dish.save
      flash[:success] = t "admin.create_success"
      redirect_to admin_dishes_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @dish.update_attributes dish_params
      flash[:success] = t "admin.update_success"
      redirect_to admin_dishes_url
    else
      render :new
    end
  end

  private

  def dish_params
    params[:dish][:status] = params[:dish][:status].to_i
    params.require(:dish).permit :category_id, :name, :price, :description,
      :status, images_attributes: [:id, :url, :_destroy]
  end

  def load_dish
    @dish = Dish.find_by id: params[:id]
    return if @dish
    flash[:danger] = t "admin.dish.not_found"
    redirect_to admin_dishes_url
  end

  def load_status_dish
    @dish_status = Dish.statuses
  end

   def map_category
    @categories = Category.all.map{|c| [c.name, c.id]}
  end
end
