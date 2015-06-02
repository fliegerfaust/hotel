class RemoveReservedRoomsFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :reserved_rooms, :string
  end
end
