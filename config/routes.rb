Rails.application.routes.draw do

  get "/", to: "welcome#index"
  get "/merchants/:merchant_id/dashboard", to: "dashboard#index"
  get "/admin/merchants", to: "admin/merchants#index"
  get "/admin/dashboard", to: "admin/dashboard#index"

  resources :merchants, only: [:show] do
    resources :dashboard, only: [:index]
    resources :items, except: [:destroy]
    resources :item_status, only: [:update]
    resources :invoices, only: [:index, :show, :update]
    resources :bulk_discounts, only: [:index, :show, :new, :create, :destroy, :edit, :update], controller: "bulk_discounts"
  end

  
  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants, except: [:destroy]
    resources :merchant_status, only: [:update]
    resources :invoices, except: [:new, :destroy]
  end
end
