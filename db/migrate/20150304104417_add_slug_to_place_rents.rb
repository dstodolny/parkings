class AddSlugToPlaceRents < ActiveRecord::Migration
  def change
    add_column :place_rents, :slug, :string
    add_index :place_rents, :slug, unique: true
  end
end
