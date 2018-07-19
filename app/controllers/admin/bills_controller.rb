class Admin::BillsController < Admin::BaseController
  before_action :logged_in_user
  before_action :load_bill, except: %i(index new create)

  def index
    @bills = Bill.code_with(params[:search])
      .ordered.page(params[:page]).per Settings.settings.per_page
  end

  def show
    @support = Supports::AdminSupport.new @bill
  end

  private

  def load_bill
    @bill = Bill.find_by_id params[:id]
    return if @bill
    flash[:danger] = t "admin.bill.not_foud_bill"
    redirect_to admin_bills_url
  end
end
