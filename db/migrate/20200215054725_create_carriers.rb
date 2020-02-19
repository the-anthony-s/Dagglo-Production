class CreateCarriers < ActiveRecord::Migration[6.0]
  def change
    create_table :carriers do |t|
      t.string :first_name
      t.string :last_name
      t.string :business_name
      t.string :business_email
      t.string :phone
      t.string :country
      t.string :state
      t.integer :num_of_trucks
      t.text :comment

      t.timestamps
    end
  end
end
