class LineItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :room
	belongs_to :cart
	
	def total_price
		room.price * quantity_item
	end
	
end
