class CreateProductBarcodes < ActiveRecord::Migration[6.0]
  def change
    create_table :product_barcodes do |t|
      t.string :barcode
      t.string :gtin14
      t.string :ean13
      t.string :upc
      t.string :prefix
      t.string :prefix_name
      t.string :country_code
      t.string :price
      t.string :base_gtin14
      t.boolean :variable, defalt: false
      t.boolean :restricted, deault: false

      t.timestamps
    end

    add_reference :products, :product_barcode, index: true
    add_reference :product_barcodes, :product, index: true
  end
end
