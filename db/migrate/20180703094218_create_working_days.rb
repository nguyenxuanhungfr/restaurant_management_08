class CreateWorkingDays < ActiveRecord::Migration[5.1]
  def change
    create_table :working_days do |t|
      t.datetime :time_start
      t.datetime :time_end
      t.references :staff, foreign_key: true

      t.timestamps
    end
  end
end
