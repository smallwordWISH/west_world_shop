class Product < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  
  has_many :order_items

  validates_presence_of :name, :price, :description

  mount_uploader :image, PhotoUploader
end
