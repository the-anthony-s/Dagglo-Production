class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :ancestry
      t.text :type_of_products
      t.text :conditions_allowed
      t.text :approval_required
      t.text :cover_date
      t.boolean :pause, default: false

      t.timestamps
    end

    add_index :categories, :ancestry
  end
end