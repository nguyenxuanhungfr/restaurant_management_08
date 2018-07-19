class AddNameStringToBills < ActiveRecord::Migration[5.1]
  def change
    add_column :bills, :name, :string
  end
end
