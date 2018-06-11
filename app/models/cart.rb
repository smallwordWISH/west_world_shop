class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def add_cart_item(product)
    existing_item = self.cart_items.find_by( product: product )
    if existing_item
      existing_item.quantity += 1
      existing_item.save!
    else
      cart_item = cart_items.build( product: product )
      cart_item.save!
    end
    self.cart_items
  end

  def calculate_total_amount
    @total_amount = 0
    self.cart_items.each do |cart_item|
      @total_amount += cart_item.product.price * cart_item.quantity  
    end
    @total_amount
  end
end
