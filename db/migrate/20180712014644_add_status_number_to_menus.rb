class AddStatusNumberToMenus < ActiveRecord::Migration[5.1]
  def change
    add_column :menus, :status, :integer
  end
end
