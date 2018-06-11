class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def calculate_subtotal
    self.price * self.quantity
  end
end
