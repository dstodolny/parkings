class ChangePricesFormatInParkingsTable < ActiveRecord::Migration
  def change
    change_column :parkings, :hour_price, :decimal
    change_column :parkings, :day_price, :decimal
  end
end
