class CreateSellers < ActiveRecord::Migration[6.0]
  def change
    create_table :sellers do |t|
      t.string :name
      t.string :business_number
      t.text :about
      t.string :country
      t.date :founding_date
      t.integer :status, :default => 0
      t.text :image_data
      t.text :cover_data
      t.timestamps
    end

    add_reference :sellers, :owner, index: true, reference: { to_table: :users }
  end
end
