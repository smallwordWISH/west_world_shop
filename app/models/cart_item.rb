class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def calculate_subtotal
    self.product.price * self.quantity
  end
end
