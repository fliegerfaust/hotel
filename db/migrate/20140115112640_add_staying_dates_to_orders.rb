class AddStayingDatesToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :date_of_arrival, :date
    add_column :orders, :date_of_departure, :date
  end
end
