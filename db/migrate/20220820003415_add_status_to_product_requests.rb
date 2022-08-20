class AddStatusToProductRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :product_requests, :status, :string
  end
end
