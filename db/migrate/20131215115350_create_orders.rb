class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.integer :days
      t.string :email
      t.string :mobile

      t.timestamps
    end
  end
end
