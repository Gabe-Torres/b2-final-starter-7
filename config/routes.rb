Rails.application.routes.draw do

  get "/", to: "welcome#index"
  get "/merchants/:merchant_id/dashboard", to: "dashboard#index"
  get "/admin/merchants", to: "admin/merchants#index"
  get "/admin/dashboard", to: "admin/dashboard#index"
  delete "/merchants/:merchant_id/bulk_discounts/:id", to: "bulk_discounts#destroy", as: :delete_bulk_discount
  patch "/merchants/:merchant_id/bulk_discounts/:id/edit", to: "bulk_discounts#update", as: :update_bulk_discount

  resources :merchants, only: [:show] do
    resources :dashboard, only: [:index]
    resources :items, except: [:destroy]
    resources :item_status, only: [:update]
    resources :invoices, only: [:index, :show, :update]
    resources :bulk_discounts, only: [:index, :show, :new, :create, :destroy, :update, :edit]
  end

  
  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants, except: [:destroy]
    resources :merchant_status, only: [:update]
    resources :invoices, except: [:new, :destroy]
  end
end
