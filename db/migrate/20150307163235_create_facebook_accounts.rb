class CreateFacebookAccounts < ActiveRecord::Migration
  def change
    create_table :facebook_accounts do |t|
      t.string :uid
      t.references :person, index: true

      t.timestamps null: false
    end
    add_foreign_key :facebook_accounts, :people
  end
end
