class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.datetime :time_start
      t.datetime :time_end
      t.integer :status
      t.string :name
      t.string :email
      t.string :address
      t.string :phone
      t.references :user, foreign_key: true
      t.references :table, foreign_key: true

      t.timestamps
    end
  end
end
