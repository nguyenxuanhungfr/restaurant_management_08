class BookingDetail < ApplicationRecord
  belongs_to :booking
  belongs_to :dish

  delegate :name, to: :dish, allow_nil: true
end
