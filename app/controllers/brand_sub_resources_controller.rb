class BrandSubResourcesController < APIController
  before_filter :get_brand

  protected

  def get_brand
    @brand = Brand.find(params[:brand_id])
  end
end