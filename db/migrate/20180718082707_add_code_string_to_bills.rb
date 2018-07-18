class AddCodeStringToBills < ActiveRecord::Migration[5.1]
  def change
    add_column :bills, :code, :string
  end
end
