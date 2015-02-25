class CreatePlaceRents < ActiveRecord::Migration
  def change
    create_table :place_rents do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.float :price
      t.references :parking, index: true
      t.references :car, index: true

      t.timestamps null: false
    end
    add_foreign_key :place_rents, :parkings
    add_foreign_key :place_rents, :cars
  end
end
