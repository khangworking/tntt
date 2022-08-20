class Admin::ProductsController < AdminController
  def index
    @products = Product.includes(:category).order(created_at: :desc).page(params[:page]).per(25)
  end

  def create
    @product = Product.new(create_params)
    if @product.save
      flash[:success] = 'Sản phẩm đã được tạo thành công!'
      redirect_to new_admin_product_path
    else
      flash[:error] = @product.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def create_params
    params.require(:product).permit(:name, :category_id, :price, :remote_image_url, :description)
  end
end
