class CreateSellerProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :seller_products do |t|
      t.string :sku
      t.string :harmonized_system_code
      t.string :packaging
      t.text :packaging_details
      t.string :supply_ability
      t.string :weight
      t.integer :units_per_case
      t.boolean :pause

      t.timestamps
    end

    add_monetize :seller_products, :unit_price, currency: { present: true }
    add_monetize :seller_products, :order_price, currency: { present: true }
    add_monetize :seller_products, :retail_price, currency: { present: true }
    add_monetize :seller_products, :sale_price, currency: { present: true }
    add_column :seller_products, :sale_start, :datetime, default: nil
    add_column :seller_products, :sale_end, :datetime, default: nil
    
    add_column :seller_products, :handling_time, :integer, default: nil
    add_column :seller_products, :max_order_quantity, :integer, default: nil

    add_reference :seller_products, :product, index: true
    add_reference :seller_products, :seller, index: true

  end
end
