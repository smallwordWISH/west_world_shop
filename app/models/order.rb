class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :payments, dependent: :destroy
  
  belongs_to :user

  validates_presence_of :total_amount, :shipping_name, :shipping_phone, :shipping_address
end
