class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:destroy, :checkout_spgateway]

  def create
    if current_cart.cart_items.length == 0
      flash[:alert] = "There is no item in your cart."
      redirect_to root_path
      return
    end

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
      UserMailer.notify_order_create(order).deliver_now!

      redirect_to orders_path
    else
      flash[:alert] = "Fail to create order. #{order.errors.full_messages.to_sentence}"

      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @orders = current_user.orders
  end

  def destroy
    if @order.payment_status == 'Unpaid'
      if @order.destroy
        flash[:notice] = "Order has been canceled."
      else
        flash[:alert] = "Fail to cancel order. #{@order.errors.full_messages.to_sentence}"
      end
    else
      flash[:alert] = "Can not delete the order which has been paid."
    end
    
    redirect_to orders_path
  end

  def checkout_spgateway
    if @order.payment_status != "unpaid"
      flash[:alert] = "Order has been paid."
      redirect_to orders_path
    else
      @payment = Payment.create!(
        sn: Time.now.to_i,
        order: @order,
        payment_method: params[:payment_method],
        total_amount: @order.total_amount
      )
    end
  end

  private

  def set_order
    @order = Order.find_by_id(params[:id])
  end

  def order_params
    params.require(:order).permit(:shipping_name, :shipping_phone, :shipping_address)
  end
end
