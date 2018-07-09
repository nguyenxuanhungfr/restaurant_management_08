class ChangePasswordToPasswordDigest < ActiveRecord::Migration[5.1]
  def change
    rename_column :staffs, :password, :password_digest
  end
end
