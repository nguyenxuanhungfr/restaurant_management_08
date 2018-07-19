class Dish < ApplicationRecord
  has_many :images, as: :imageable
  has_many :menu_dishes
  has_many :booking_details
  has_many :bookings, through: :booking_details
  has_many :reviews
  has_many :users, through: :reviews
  belongs_to :category

  scope :ordered, ->{order created_at: :desc}
  scope :search, ->(search){
    where("name LIKE ? or description LIKE ?",
    "%#{search}%", "%#{search}%") if search.present?}
  scope :filter_by_category, ->(category_id){where(category_id: category_id)if
    category_id.present?}
  scope :filter_by_status, ->(status){where(status: status) if status.present?}
  scope :load_dish_of_cate, ->(cate_id){joins("inner join menu_dishes as md on d.id = md.dish_id inner join categories as ct on ct.id = d.category_id where ct.id=2 group by d.name")}

  enum status: %i(out_of_stock stock)

  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: ->(attrs) {attrs["url"].blank?}

  validates :name, presence: true
  validates :category_id, presence: true
  validates :price, presence: true, format:
    {with: Settings.settings.vald_reg},
    numericality: {greater_than: Settings.settings.min_money,
    less_than: Settings.settings.max_money}

  def rating point
    update_attributes average_point: point
  end
end
