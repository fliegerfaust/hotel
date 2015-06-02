class StoreController < ApplicationController
	skip_before_action :authorize

  def index
  	@rooms = Room.order(:price)
  	@cart = current_cart
  end
end
