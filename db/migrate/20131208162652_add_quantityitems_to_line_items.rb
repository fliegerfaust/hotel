class AddQuantityitemsToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :quantityitems, :integer, default: 1
  end
end
