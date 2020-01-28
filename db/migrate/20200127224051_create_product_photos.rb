class CreateProductPhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :product_photos do |t|
      t.references(:product, foreign_key: true)
      t.string :name
      t.text :image_data

      t.timestamps
    end
  end
end
