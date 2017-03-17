Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  resources :brands, only: [:index, :show] do
    resources :order_types, only: [:index]
    resources :price_levels, only: [:index]
    resources :menu_items, only: [:index]
    resources :locations, only: [:index, :show] do
      get :menu_item_price, on: :member
      resources :day_parts, only: [:index]
    end
  end

  root 'admin/dashboard#index'
end
