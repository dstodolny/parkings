class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :accounts, :password, :password_digest
  end
end
