class CreateParkings < ActiveRecord::Migration
  def change
    create_table :parkings do |t|
      t.integer :places
      t.string :kind
      t.integer :hour_price
      t.integer :day_price
      t.references :address, index: true
      t.references :owner, index: true
    end
    add_foreign_key :parkings, :addresses
    add_foreign_key :parkings, :owners
  end
end
