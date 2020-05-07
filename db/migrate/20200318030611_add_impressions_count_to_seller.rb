class AddImpressionsCountToSeller < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :views, :int, default: 0
  end
end
