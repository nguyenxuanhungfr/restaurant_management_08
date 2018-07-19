class Menu < ApplicationRecord
  has_many :menu_dishes
  has_many :dishes, through: :menu_dishes

  enum status: %i(hide display)

  scope :ordered, -> {order created_at: :desc}
  scope :search_by_type, ->(name){
    where("name LIKE ?", "%#{name}%") if name.present?}
  scope :filter_by_table, ->(table_id){where(status: table_id) if table_id.present?}

  validates :name, presence: true
end
