class Bill < ApplicationRecord
  belongs_to :user
  belongs_to :booking

  scope :ordered, ->{order created_at: :desc}
  scope :name_with, -> (name) {where("name like ?", "#{name}%")}

  delegate :name, to: :user, allow_nil: true, prefix: true
end
