class AddAddressLatitudeLongitudeToItem < ActiveRecord::Migration
  def change
    add_column :items, :address, :string
    add_column :items, :latitude, :float
    add_column :items, :longitude, :float

    add_index :items, [:latitude, :longitude]
    add_index :items, :address
  end
end
