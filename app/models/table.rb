class Table < ApplicationRecord
  has_many :images, as: :imageable
  has_many :bookings
  has_many :users, through: :bookings
end
