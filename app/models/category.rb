class Category < ApplicationRecord
  has_many :dishes

  enum status: %i(hide display)
  scope :ordered, ->{order created_at: :desc}
end
