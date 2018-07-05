class CreateMenuDishes < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_dishes do |t|
      t.references :dish, foreign_key: true
      t.references :menu, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
