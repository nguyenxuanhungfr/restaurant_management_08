class Category < ApplicationRecord
  has_many :dishes

  validates :name, presence: true,uniqueness: true, length: {maximum: Settings.validate.content_max_length}

  enum status: %i(hide display)
  scope :ordered, ->{order created_at: :desc}
end
