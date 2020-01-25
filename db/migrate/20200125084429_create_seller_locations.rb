class CreateSellerLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :seller_locations do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :zip
      t.string :state
      t.string :country
      t.float :longitude
      t.float :latitude
      t.string :phone
      t.boolean :pause, default: false

      t.timestamps
    end

    add_reference :seller_locations, :seller, index: true
    add_reference :seller_accounts, :seller_location, index: true
  end
end
