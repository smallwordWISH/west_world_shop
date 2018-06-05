class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :sn
      t.float :total_amount
      t.string :shipping_name
      t.string :shipping_phone
      t.string :shipping_address
      t.string :payment_status
      t.string :shipping_status
      
      t.timestamps
    end
  end
end
