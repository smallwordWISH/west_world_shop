class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: [:update, :destroy]

  def index
    @orders = Order.all
  end

  def update
    if @order.update(order_params)
      flash[:notice] = "Successfully updated order ##{@order.sn}"
    else
      flash[:alert] = "Fail to update order. #{@order.errors.full_messages.to_sentence}"
    end

    redirect_to admin_orders_path      
  end

  def destroy
    if @order.payment_status == 'Unpaid'
      if @order.destroy
        flash[:notice] = "Successfully deleted order ##{@order.sn}"
      else
        flash[:alert] = "Fail to delete order. #{@order.errors.full_messages.to_sentence}"
      end
    else
      flash[:alert] = "Can not delete the order which has been paid."
    end

    redirect_to admin_orders_path
  end

  private

  def set_order
    @order = Order.find_by_id(params[:id])
  end

  def order_params
    params.require(:order).permit(:payment_status, :shipping_status)
  end
end
