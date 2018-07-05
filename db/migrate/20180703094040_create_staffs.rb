class CreateStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :staffs do |t|
      t.string :name
      t.string :email
      t.integer :role
      t.integer :salary
      t.integer :work_days
      t.string :image
      t.string :password

      t.timestamps
    end
  end
end
