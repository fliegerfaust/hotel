class CartsController < ApplicationController
	skip_before_action :authorize, only: [:create, :update, :destroy, :show]
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def index
    @carts = Cart.all
  end

  def show
  	@cart = current_cart
  end

  def new
    @cart = Cart.new
  end

  def edit
  end

  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'R-list was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cart }
      else
        format.html { render action: 'new' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'R-list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

 def destroy
    @cart = current_cart if @cart.id == session[:cart_id]
    @cart.destroy
    session[:cart_id] = nil
    
    room = Room.find_by_roomtype("cтандарт")
    room.quantity = room.quantity + session[:first_type_quant].to_i
    session[:first_type] = ""
    session[:first_type_quant] = 0
    room.save 
    
    room = Room.find_by_roomtype("улучшенный")
    room.quantity = room.quantity + session[:second_type_quant].to_i
    session[:second_type] = ""
    session[:second_type_quant] = 0
    room.save 
    
    room = Room.find_by_roomtype("двухкомнатный")
    room.quantity = room.quantity + session[:third_type_quant].to_i
    session[:third_type] = ""
    session[:third_type_quant] = 0
    room.save 
    
    respond_to do |format|
      format.html { redirect_to store_url,
        notice: 'Список бронирования пуст!' }
      format.json { head :no_content }
    end
  end

  private
  	def set_cart
      @cart = Cart.find(params[:id])
    end

    def cart_params
      params[:cart]
    end
    
    def invalid_cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to store_url, notice: 'Invalid cart'
    end
end
