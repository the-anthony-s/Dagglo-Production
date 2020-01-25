class CreateSellerProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :seller_products do |t|
      t.money :unit_price
      t.money :min_order_price
      t.string :sku, limit: 10
      t.string :harmonized_system_code
      t.string :country_code_of_origin
      t.string :province_code_of_origin
      t.string :barcode
      t.string :packaging
      t.text :packaging_details
      t.string :shelf_life
      t.string :supply_ability
      t.string :weight
      t.string :status
      t.boolean :pause

      t.timestamps
    end

    add_reference :seller_products, :product, index: true
    add_reference :seller_products, :seller, index: true

  end
end
