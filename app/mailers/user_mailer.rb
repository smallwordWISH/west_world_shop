class UserMailer < ApplicationMailer
  default from: "My Cart <info@westworld.co>"

  def notify_order_create(order)
    @order = order
    @content = "Your order has been successfully created. Thank you!"

    mail to: order.user.email,
    subject: "West World Shop | Order: ##{@order.sn}"
  end
end
