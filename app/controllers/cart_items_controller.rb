class CartItemsController < ApplicationController
  before_action :set_cart_item

  def destroy
    @cart_item.destroy

    redirect_to root_path
  end

  def plus
    quantity = @cart_item.quantity + 1

    @cart_item.update_attributes(quantity: quantity)    
  end

  def minus
    quantity = @cart_item.quantity - 1

    @cart_item.update_attributes(quantity: quantity) 
  end

  private

  def set_cart_item
    @cart_item = CartItem.find_by_id(params[:id])
  end
end
