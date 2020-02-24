class CreateTerms < ActiveRecord::Migration[6.0]
  def change
    create_table :terms do |t|

      t.string :name
      t.text   :content
      t.boolean :pause

      t.timestamps
    end
  end
end
