class ProductRequestsController < ApplicationController
  def new
    @product_request = ProductRequest.includes(product_request_lines: :product).new(product_request_lines: build_line_fields)
  end

  def create
    @product_request = ProductRequest.new(create_params)
    if @product_request.save
      flash[:success] = 'Cảm ơn quý phụ huynh, Bộ phận bán hàng của Xứ Đoàn sẽ gọi lại xác nhận ạ!'
      redirect_to new_product_request_path
    else
      flash[:danger] = @product_request.errors.full_messages.join(', ')
      @product_request.product_request_lines = build_line_fields
      render :new
    end
  end

  private

  def create_params
    params.require(:product_request).permit(
      :student_chirstian_name,
      :student_name,
      :parent_name,
      :phone,
      :address,
      :level_id,
      product_request_lines_attributes: %i[checked product_id]
    ).tap do |whitelist|
      whitelist[:status] = 'created'
    end
  end

  def build_line_fields
    Product.joins(:category).where(categories: { active: true }).distinct.map do |product|
      ProductRequestLine.new(product_id: product.id, product_name: product.name)
    end
  end
end
