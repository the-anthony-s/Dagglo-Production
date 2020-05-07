class CreateSellerAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :seller_accounts do |t|
      t.integer :role
      
      t.timestamps
    end

    add_reference :seller_accounts, :user, index: true, unique: true
    add_reference :seller_accounts, :seller, index: true
  end
end
