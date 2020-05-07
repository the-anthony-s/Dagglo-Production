class CreatePricings < ActiveRecord::Migration[6.0]
  def change
    create_table :pricings do |t|
      t.timestamps
    end

    add_monetize :pricings, :unit_price, currency: { present: true }
    add_monetize :pricings, :order_price, currency: { present: true }
    add_monetize :pricings, :sale_price, currency: { present: true }
    add_monetize :pricings, :retail_price, currency: { present: true }
    
    add_column :pricings, :sale_start, :datetime, default: nil
    add_column :pricings, :sale_end, :datetime, default: nil

    add_reference :pricings, :product, index: true
    add_reference :pricings, :seller_product, index: true
    add_reference :pricings, :seller, index: true
  end
end
