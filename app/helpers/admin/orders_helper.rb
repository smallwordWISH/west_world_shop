module Admin::OrdersHelper
  def options_for_payment_status
    [
      ['Unpaid', 'unpaid'],
      ['Paid', 'paid']
    ]
  end

  def options_for_shipping_status
    [
      ['Not shipped yet', 'not shipped yet'],
      ['In delivery', 'in delivery'],
      ['Delivered', 'delivered'],
    ]
  end
end
