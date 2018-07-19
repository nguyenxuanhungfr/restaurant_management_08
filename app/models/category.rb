class Category < ApplicationRecord
  has_many :dishes

  validates :name, presence: true,uniqueness: true, length: {maximum: Settings.validate.content_max_length}

  enum status: %i(hide display)
  scope :ordered, ->{order created_at: :desc}
  scope :load_cate_of_menu, ->(menu_id){
    joins("inner join dishes as d on categories.id = d.category_id
      inner join menu_dishes as md on d.id=md.dish_id
      where md.menu_id = #{menu_id}
      group by categories.id") if menu_id.present?}
  scope :search_by_type, ->(name){
    where("name LIKE ?", "%#{name}%") if name.present?}
  scope :filter_by_table, ->(table_id){where(status: table_id) if table_id.present?}
end
