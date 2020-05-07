class CreatePriceHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :price_histories do |t|
      t.timestamps
    end

    add_reference :price_histories, :product, index: true
    add_reference :price_histories, :seller, index: true
    add_reference :price_histories, :seller_product, index: true

    add_monetize :price_histories, :unit_price, currency: { present: true }
  end
end
