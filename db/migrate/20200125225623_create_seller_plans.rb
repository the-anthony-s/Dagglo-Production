class CreateSellerPlans < ActiveRecord::Migration[6.0]
  def change
    create_table :seller_plans do |t|
      t.string :name
      t.integer :amount
      t.string :interval
      t.string :stripe_id

      # Plan Stats
      t.integer :num_of_products
      t.integer :num_of_locations
      t.integer :num_of_sub_accounts
      t.string :analytics

      t.boolean :pause, default: "false"

      t.timestamps
    end
  end
end
