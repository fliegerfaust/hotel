class Room < ActiveRecord::Base

	has_many :line_items
	has_many :orders, through: :line_items
	
	before_destroy :ensure_not_referenced_by_any_line_item
	
	ROOM_QUANTITY = (1..15).to_a
	
	validates :title, :roomtype, :description, :image_url, presence: true
	validates :price, numericality: {greater_that_or_equal_to: 500.0}
	validates :quantity, numericality: {greater_than_or_equal_to: 0}
	validates :image_url, allow_blank: true, format: {
		with: /\.(gif|jpg|jpeg|png)\z/i,
		message: ': Must be a URL for GIF, JPEG, JPG or PNG image'
	}
	
	# Каждый день в 12:00 стартует проверка:
	# сколько номеров определённого типа освобождается сегодня?
	# Количество номеров прибавляем к кол-ву свободных номеров этого же типа.
	def every_day_rooms_control
		require 'date'
		@today = Date.today
		
		@dep_one = Room.joins(:orders).where("orders.date_of_departure = ? AND rooms.title = ? 
													AND rooms.roomtype = ?",@today,'Одноместный','стандарт').count
		@dep_two = Room.joins(:orders).where("orders.date_of_departure = ? AND rooms.title = ? 
													AND rooms.roomtype = ?",@today,'Одноместный','улучшенный').count
		@dep_three = Room.joins(:orders).where("orders.date_of_departure = ? AND rooms.title = ? 
													AND rooms.roomtype = ?",@today,'Двухместный','двухкомнатный').count
		case
			when Room.title == 'Одноместный' && Room.roomtype == 'стандарт'
				Room.quantity = Room.quantity + @dep_one
			when Room.title == 'Одноместный' && Room.roomtype == 'улучшенный'
				Room.quantity = Room.quantity + @dep_two
			when Room.title == 'Двухместный' && Room.roomtype == 'двухкомнатный'
				Room.quantity = Room.quantity + @dep_three
		end	 
	end
	
	
	private
	
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line items exists')
			return false
		end
	end
	
end
