class AddImpressionsCountToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :views, :int, default: 0
  end
end
