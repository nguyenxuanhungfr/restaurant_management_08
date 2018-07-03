class User < ApplicationRecord
  has_many :bills
  has_many :bookings
  has_many :reviews
  has_many :dishes, through: :reviews
  has_many :bookings
  has_many :tables, through: :bookings
end
