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

    redirect_to admin_root_path
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "Have successfully updated the product."
    else 
      flash[:alert] = "Fail to update the product. #{@product.errors.full_messages.to_sentence}"
    end

    redirect_to admin_root_path
  end

  def destroy
    @product.destroy

    redirec_to admin_root_path, notice: "Product has successfully deleted"
  end

  private

  def set_product
    @product = Product.find_by_id(params[:id])  
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end

end
