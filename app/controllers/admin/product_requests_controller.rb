class Admin::ProductRequestsController < AdminController
  def index
    @resources = ProductRequest.includes(:product_request_lines).order(created_at: :desc).page(params[:page]).per(25)
  end
end
