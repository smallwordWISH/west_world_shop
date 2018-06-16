class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  default_scope { order(created_at: :asc) }

  def calculate_subtotal
    self.product.price * self.quantity
  end
end
