class Dish < ApplicationRecord
  has_many :images, as: :imageable
  has_many :menu_dishes
  has_many :booking_details
  has_many :bookings, through: :booking_details
  has_many :reviews
  has_many :users, through: :reviews
  belongs_to :category

  scope :ordered, ->{order created_at: :asc}
end
