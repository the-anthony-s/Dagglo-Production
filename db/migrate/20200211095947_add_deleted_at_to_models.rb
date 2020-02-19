class AddDeletedAtToModels < ActiveRecord::Migration[6.0]
  def change

    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at

    add_column :sellers, :deleted_at, :datetime
    add_index :sellers, :deleted_at

    add_column :seller_accounts, :deleted_at, :datetime
    add_index :seller_accounts, :deleted_at

    add_column :seller_charges, :deleted_at, :datetime
    add_index :seller_charges, :deleted_at

    add_column :seller_locations, :deleted_at, :datetime
    add_index :seller_locations, :deleted_at

    add_column :seller_products, :deleted_at, :datetime
    add_index :seller_products, :deleted_at

    add_column :products, :deleted_at, :datetime
    add_index :products, :deleted_at

  end
end
