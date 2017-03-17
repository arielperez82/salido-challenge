class LocationsController < BrandSubResourcesController
  def index
    respond_with @brand.locations
  end

  def show
    respond_with @brand.locations.find(params[:id])
  end

  def menu_item_price
     @location = @brand.locations.find(params[:id])
     @menu_item = @brand.menu_items.where(id: params[:menu_item_id]).first
     @order_type = @brand.order_types.where(id: params[:order_type_id]).first
     @day_part = @location.day_parts.where(id: params[:order_type_id]).first

     @price_and_level = @location.get_menu_item_price_and_level(@menu_item, @order_type, @day_part)

     respond_with @price_and_level || {}
  end
end