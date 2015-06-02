class ApplicationController < ActionController::Base
  before_action :authorize
  protect_from_forgery with: :exception
  
  protected
  
  	def authorize
  		unless User.find_by_id(session[:user_id])
  			redirect_to login_url
  			flash[:error] = 'Пожалуйста, войдите, используя логин и пароль администратора.'
  		end
  		
  		if User.count.zero?
    		redirect_to new_user_path, :notice => "Пожалуйста, создайте пользователя."
  		end
  	end
  
  private
  
  	def current_cart
  		Cart.find(session[:cart_id])
  	rescue ActiveRecord::RecordNotFound
  		cart = Cart.create
  		session[:cart_id] = cart.id
  		cart  
  	end
  
end
