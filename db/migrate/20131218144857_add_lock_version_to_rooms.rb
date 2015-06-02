class AddLockVersionToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :lock_version, :integer, default: 0, null: false
  end
end
