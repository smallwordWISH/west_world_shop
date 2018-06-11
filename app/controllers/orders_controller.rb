class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    order = Order.new(order_params)
    order.user = current_user
    order.payment_status = "unpaid"
    order.shipping_status = "not shipped yet"
    order.sn = "0#{rand(10..99)}#{Time.now.strftime("%Y%m%d%H%M%S")}#{current_user.id}".to_i
    order.total_amount = current_cart.calculate_total_amount

    if order.save
      flash[:notice] = "Order has successfully created."

      current_cart.cart_items.each do |cart_item|
        order_item = order.order_items.build(product: cart_item.product, price: cart_item.product.price, quantity: cart_item.quantity)
        order_item.save
      end

      current_cart.destroy

      redirect_to orders_path
    else
      flash[:alert] = "Fail to create order. #{order.errors.full_messages.to_sentence}"

      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @orders = Order.all
  end

  def destroy
    @order = Order.find_by_id(params[:id])

    if @order.destroy
      flash[:notice] = "Order has been cancel."
    else
      flash[:alert] = "Fail to cancel order. #{@order.errors.full_messages.to_sentence}"
    end
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:shipping_name, :shipping_phone, :shipping_address)
  end
end
