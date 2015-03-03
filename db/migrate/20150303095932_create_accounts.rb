class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :password
      t.references :person, index: true

      t.timestamps null: false
    end
    add_foreign_key :accounts, :people
  end
end
