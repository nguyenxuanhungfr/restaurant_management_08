class CreateDishes < ActiveRecord::Migration[5.1]
  def change
    create_table :dishes do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.integer :status
      t.float :average_point
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
