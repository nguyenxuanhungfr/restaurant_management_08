class Review < ApplicationRecord
  belongs_to :user
  belongs_to :dish

  validates :comment, presence: true

  delegate :name, :image, to: :user, allow_nil: true

  scope :ordered, -> {order point: :desc}
end
