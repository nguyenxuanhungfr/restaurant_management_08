class Menu < ApplicationRecord
  has_many :menu_dishes
  has_many :dishes, through: :menu_dishes

  enum status: %i(hide display)

  scope :ordered, -> {order created_at: :desc}

  validates :name, presence: true
end
