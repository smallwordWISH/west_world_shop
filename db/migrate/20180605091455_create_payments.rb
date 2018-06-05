class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :sn
      t.float :total_amount
      t.string :payment_method
      t.datetime :paid_at
      t.text :params

      t.timestamps
    end
  end
end
