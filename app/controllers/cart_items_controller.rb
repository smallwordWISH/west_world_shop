class CartItemsController < ApplicationController
  before_action :set_cart_item

  def destroy
    @cart_item.destroy

    render "products/add_to_cart"
  end

  def plus
    quantity = @cart_item.quantity + 1

    @cart_item.update_attributes(quantity: quantity)    

    render "products/add_to_cart"
  end

  def minus
    quantity = @cart_item.quantity - 1

    @cart_item.update_attributes(quantity: quantity)

    render "products/add_to_cart" 
  end

  private

  def set_cart_item
    @cart_item = CartItem.find_by_id(params[:id])
  end
end
