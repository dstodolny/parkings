class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :registration_number
      t.string :model
      t.references :owner, index: true

      t.timestamps null: false
    end
    add_foreign_key :cars, :owners
  end
end
