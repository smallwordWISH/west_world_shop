class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def add_to_cart
    @product = Product.find_by_id(params[:id])

    current_cart.add_cart_item(@product)

    flash[:notice] = "Product has added to cart successfully"
    redirect_to root_path
  end

end
