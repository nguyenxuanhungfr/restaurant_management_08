class Staff < ApplicationRecord
  has_many :salaries
  has_many :working_days
  has_secure_password
end
