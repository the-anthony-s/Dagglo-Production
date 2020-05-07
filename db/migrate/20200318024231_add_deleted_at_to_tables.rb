class AddDeletedAtToTables < ActiveRecord::Migration[6.0]
  def change
    
    # User table + Related
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at

    add_column :user_locations, :deleted_at, :datetime
    add_index :user_locations, :deleted_at



    # Seller table + Related
    add_column :sellers, :deleted_at, :datetime
    add_index :sellers, :deleted_at

    add_column :seller_accounts, :deleted_at, :datetime
    add_index :seller_accounts, :deleted_at

    add_column :seller_locations, :deleted_at, :datetime
    add_index :seller_locations, :deleted_at

    add_column :seller_products, :deleted_at, :datetime
    add_index :seller_products, :deleted_at

    add_column :seller_subscriptions, :deleted_at, :datetime
    add_index :seller_subscriptions, :deleted_at

    add_column :seller_charges, :deleted_at, :datetime
    add_index :seller_charges, :deleted_at


    
    # Product table + Related
    add_column :products, :deleted_at, :datetime
    add_index :products, :deleted_at

    add_column :product_likes, :deleted_at, :datetime
    add_index :product_likes, :deleted_at
  end
end
