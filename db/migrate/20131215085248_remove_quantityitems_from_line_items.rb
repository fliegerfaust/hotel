class RemoveQuantityitemsFromLineItems < ActiveRecord::Migration
  def change
    remove_column :line_items, :quantityitems, :integer
  end
end
