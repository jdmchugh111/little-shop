
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index'

  # resources :merchants, only: :dashboard do
  #   get 'dashboard', on: :member
  # end

# get "/merchants/:merchant_id/dashboard", to: "merchants/dashboard#show"

resources :merchants, only: [] do
  resources :dashboard, only: [:index], action: :show, controller: 'merchants/dashboard'
  resources :invoices, only: [:index, :show], controller: 'merchants/invoices'
  resources :items, only: [:index, :show, :edit, :new, :create], controller: 'merchants/items'
end

patch "/merchants/:merchant_id/items/:id", to: "merchants/items#update", as: "merchant_item_update"

resources :admin, only: :index

namespace :admin do
  resources :merchants, only: [:index, :show, :edit]
end

patch "/admin/merchants/:id", to: "admin/merchants#update"

end