class CreateAnnouncements < ActiveRecord::Migration[6.0]
  def change
    create_table :announcements do |t|
      t.string :name
      t.text :content
      t.text :image_data
      t.integer :audience
      t.boolean :hide

      t.timestamps
    end
  end
end
