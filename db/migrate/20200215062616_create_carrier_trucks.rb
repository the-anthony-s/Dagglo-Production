class CreateCarrierTrucks < ActiveRecord::Migration[6.0]
  def change
    create_table :carrier_trucks do |t|
      t.string :name
      t.text :description
    end
  end
end
