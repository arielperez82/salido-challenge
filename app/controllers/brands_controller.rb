class BrandsController < APIController
  def index
    respond_with Brand.all
  end

  def show
    respond_with Brand.find(params[:id])
  end
end