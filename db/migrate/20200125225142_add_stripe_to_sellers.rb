class AddStripeToSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :stripe_id, :string
    add_column :sellers, :card_brand, :string
    add_column :sellers, :card_last4, :string
    add_column :sellers, :card_exp_month, :string
    add_column :sellers, :card_exp_year, :string
  end
end
