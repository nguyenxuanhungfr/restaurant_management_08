class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :tables do |t|
      t.integer :number_of_people
      t.integer :type
      t.text :description

      t.timestamps
    end
  end
end
