class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_cart 
  helper_method :calculate_cart_total_quantity

  private

  def current_cart
    @cart || set_cart
  end

  def set_cart
    if session[:cart_id]
      @cart = Cart.find_by_id(session[:cart_id])
    end

    @cart ||= Cart.create

    session[:cart_id] = @cart.id
    @cart
  end

  def calculate_cart_total_quantity(cart_items)
    totoal_quantity = 0
    cart_items.each do |cart_item|
      totoal_quantity += cart_item.quantity
    end

    totoal_quantity
  end
end
