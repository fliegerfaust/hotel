class CombineItemsInCart < ActiveRecord::Migration
  def up
  	# замена нескольких записей для одной и той же комнаты в R-list одной записью
  	Cart.all.each do |cart|
  		# подсчёт кол-ва каждой команты(типа комнаты) в R-list
  		sums = cart.line_items.group(:room_id).sum(:quantity_item)
  		
  		sums.each do |room_id, quantity_item|
  			if quantity_item > 1
  				# удаление отдельных записей
  				cart.line_items.where(room_id: room_id).delete_all
  				
  				# замена одной записью
  				cart.line_items.create(room_id: room_id, quantity_item: quantity_item)
  			end
  		end
  	end
  end
  
  def down
  end
end
