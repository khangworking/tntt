class Admin::CategoriesController < AdminController
  def index
    @categories = Category.includes(:products).order(created_at: :desc).page(params[:page]).per(25)
  end

  def create
    @category = Category.new(create_params)
    if @category.save
      respond_to do |format|
        format.html { head :no_content }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html do
          flash[:danger] = 'Something wrong, please contact to admin'
          redirect_back fallback_location: admin_categories_path
        end
        format.turbo_stream
      end
    end
  end

  private

  def create_params
    params.require(:category).permit(:name)
  end
end
