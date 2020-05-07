class CreateProductVariations < ActiveRecord::Migration[6.0]
  def change
    create_table :product_variations do |t|
      t.string :name
      t.string :field_type
      t.boolean :required
      t.belongs_to :category
      t.boolean :pause, :default => false

      t.timestamps
    end
  end
end
