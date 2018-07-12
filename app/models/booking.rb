class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :table
  has_many :booking_details
  has_many :dishes, through: :booking_details
  has_many :bills

  delegate :name, to: :user, prefix: true
  delegate :number_of_people, to: :table, prefix: true

  scope :search_by_type, ->(name){where("name LIKE ? or phone LIKE ?", "%#{name}%", "%#{name}%") if name.present?}
end
