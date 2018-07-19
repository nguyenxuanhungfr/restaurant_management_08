class Bill < ApplicationRecord
  belongs_to :user
  belongs_to :booking

  scope :ordered, ->{order created_at: :desc}
  scope :code_with, -> (code) {where("code like ?", "#{code}%")}

  delegate :name, to: :user, allow_nil: true, prefix: true
end
