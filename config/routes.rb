Rails.application.routes.draw do
  resources :earnings, only: [:index, :new, :create, :show]
  resources :items, only: [:index, :new, :create, :show, :edit, :update]
  resources :charges
  root to: 'items#index'
end
