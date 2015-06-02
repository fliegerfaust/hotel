class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :title
      t.string :roomtype
      t.text :description
      t.string :image_url
      t.integer :quantity
      t.decimal :price, precision: 8, scale: 0

      t.timestamps
    end
  end
end
