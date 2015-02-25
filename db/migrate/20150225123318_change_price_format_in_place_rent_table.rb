class ChangePriceFormatInPlaceRentTable < ActiveRecord::Migration
  def change
    change_column :place_rents, :price, :decimal
  end
end
