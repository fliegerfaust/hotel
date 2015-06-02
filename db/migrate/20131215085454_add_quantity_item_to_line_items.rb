class AddQuantityItemToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :quantity_item, :integer, default: 1
  end
end
