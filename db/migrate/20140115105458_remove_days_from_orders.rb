class RemoveDaysFromOrders < ActiveRecord::Migration
  def change
  	remove_column :orders, :days, :integer
  end
end
