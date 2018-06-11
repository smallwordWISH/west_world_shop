class AddForignKeyAndDefault < ActiveRecord::Migration[5.1]
  def change
    add_column :cart_items, :cart_id, :integer
    add_column :cart_items, :product_id, :integer
    change_column_default :cart_items, :quantity, 1

    add_column :order_items, :product_id, :integer
    add_column :order_items, :order_id, :integer

    add_column :orders, :user_id, :integer
    
    add_column :payments, :order_id, :integer
  end
end
