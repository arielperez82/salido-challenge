class DayPartsController < APIController
  before_filter :get_location

  def index
    respond_with @location.day_parts
  end

  private

  def get_location
    @location = Location.where(brand_id: params[:brand_id]).find(params[:location_id])
  end
end