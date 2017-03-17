class MenuItemsController < BrandSubResourcesController
  def index
    respond_with @brand.menu_items
  end
end