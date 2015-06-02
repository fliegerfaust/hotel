class LineItemsController < ApplicationController
	skip_before_action :authorize, only: :create
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  def index
    @line_items = LineItem.all
  end

  def show
  end

  def new
    @line_item = LineItem.new
  end

  def edit
  end

  def create
    @cart = current_cart
    room = Room.find(params[:room_id])
    @line_item = @cart.add_room(room.id)
    
    #session[:first_type_quant] = 0
    #session[:second_type_quant] = 0
    #session[:third_type_quant] = 0
	 	
	 	case
	 		when @line_item.room.title + " " + @line_item.room.roomtype == "Одноместный cтандарт"
	 			session[:first_type_quant] = @line_item.quantity_item
	 			session[:first_type] = @line_item.room.title + " " + @line_item.room.roomtype
	 		when @line_item.room.title + " " + @line_item.room.roomtype == "Одноместный улучшенный"
	 			session[:second_type_quant] = @line_item.quantity_item
	 			session[:second_type] = @line_item.room.title + " " + @line_item.room.roomtype
	 		when @line_item.room.title + " " + @line_item.room.roomtype == "Двухместный двухкомнатный"
	 			session[:third_type_quant] = @line_item.quantity_item
	 			session[:third_type] = @line_item.room.title + " " + @line_item.room.roomtype
	 	end
	 
    respond_to do |format|
    	if room.quantity != 0
      	if @line_item.save
      		room.quantity -= 1
      		room.save
        	format.html { redirect_to @line_item.cart, 
        								notice: 'Номер добавлен в список бронирования.' }
        	format.json { render json: @line_item, status: :created, location: @line_item }
      	else
        	format.html { render action: 'new' }
        	format.json { render json: @line_item.errors, status: :unprocessable_entity }
      	end
      else
      	format.html { redirect_to store_path, notice: 'Извините, этот тип комнат закончился.' }
      end
    end
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to line_items_url }
      format.json { head :no_content }
    end
  end

  private
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:room_id, :cart_id)
    end
end
