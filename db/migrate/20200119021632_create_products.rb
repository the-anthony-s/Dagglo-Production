class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'hstore'
    
    create_table :products do |t|
      t.string :name
      t.text :description
      t.hstore :variations
      t.string :country_code
      t.string :barcode
      t.integer :status, default: 0
      t.timestamps
    end

    
    add_reference :products, :category, index: true

    # get creater account ID and account seller ID
    add_reference :products, :owner_user, index: true, reference: { to_table: :users }
    add_reference :products, :owner_seller, index: true, reference: { to_table: :sellers }
  end
end
