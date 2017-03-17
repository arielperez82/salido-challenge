class OrderTypesController < BrandSubResourcesController
  def index
    respond_with @brand.order_types
  end
end