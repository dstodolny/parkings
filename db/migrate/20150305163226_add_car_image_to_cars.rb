class AddCarImageToCars < ActiveRecord::Migration
  def change
    add_column :cars, :image_uid, :string
    add_column :cars, :image_name, :string
  end
end
