class CreateSalaries < ActiveRecord::Migration[5.1]
  def change
    create_table :salaries do |t|
      t.integer :salary_grade
      t.integer :salary
      t.references :staff, foreign_key: true

      t.timestamps
    end
  end
end
