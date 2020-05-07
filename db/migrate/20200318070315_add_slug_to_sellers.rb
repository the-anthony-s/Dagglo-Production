class AddSlugToSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :slug, :string
    add_index :sellers, :slug, unique: true
  end
end
