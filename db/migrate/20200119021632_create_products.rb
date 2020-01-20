class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :barcode
      t.text :about
      t.string :country
      t.integer :min_amount
      t.integer :num_offers
      t.boolean :manufacturer_warranty
      t.integer :status, default: 0
      t.text :image_data

      t.timestamps
    end

    
    add_reference :products, :category, index: true

    # get creater account ID and account seller ID
    add_reference :products, :owner_user, index: true, reference: { to_table: :users }
    add_reference :products, :owner_seller, index: true, reference: { to_table: :sellers }
  end
end
