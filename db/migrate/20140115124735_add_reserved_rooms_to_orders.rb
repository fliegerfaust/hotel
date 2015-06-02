class AddReservedRoomsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :reserved_rooms, :text
  end
end
