class CreateUserLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_locations do |t|
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :zip
      t.string :state
      t.string :country
      t.float :longitude
      t.float :latitude

      t.timestamps
    end

    add_reference :user_locations, :user, index: true
  end
end
