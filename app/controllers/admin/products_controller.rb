class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:edit, :update, :destroy, :add_to_cart]

  helper_method :current_cart

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    
    if @product.save
      flash[:notice] = "Product was successfully created."
    else
      flash[:notice] = "Product was failed to creat. #{@product.errors.full_messages.to_sentence}"
    end
  end

  def edit
  end

  def update
    
  end

  def destroy
    
  end

  private

  def ser_product
    @product = Product.find_by_id(params)  
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end

end
