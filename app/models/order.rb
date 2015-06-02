class Order < ActiveRecord::Base

	has_many :line_items, dependent: :destroy

	validates :name, :date_of_arrival, :date_of_departure, :email, :mobile, presence: true
	
	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
			item.cart_id = nil
			line_items << item
		end	
	end
	
	#ROOM_QUANTITY = (1..15).to_a

end
