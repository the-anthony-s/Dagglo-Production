class CreateCarriersCarrierTrucks < ActiveRecord::Migration[6.0]
  def change
    create_table :carriers_carrier_trucks, id: false do |t|
      t.integer :carrier_id
      t.integer :carrier_truck_id
    end
  end
end
