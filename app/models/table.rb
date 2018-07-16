class Table < ApplicationRecord
  has_many :images, as: :imageable
  has_many :bookings
  has_many :users, through: :bookings

  enum type_table: {normal: Settings.settings.nomal, vip: Settings.settings.vip}

  scope :ordered, ->{order created_at: :desc}
  scope :search_by_number_of_people, ->(number){where("number_of_people <= ?", number) if number.present?}
  scope :search_by_type_table, ->(type_table){where(type_table: type_table) if type_table.present?}

  validates :number_of_people, presence: true
  validates :name, presence: true

  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: ->(attrs) {attrs["url"].blank?}
end
