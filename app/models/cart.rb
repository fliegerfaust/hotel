class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy
	
	def add_room(room_id)
		current_item = line_items.find_by_room_id(room_id)
		if current_item
			current_item.quantity_item += 1
		else
			current_item = line_items.build(room_id: room_id) 
		end
	current_item
	end
	
	def total_price
		line_items.to_a.sum { |item| item.total_price }
	end
	
end
