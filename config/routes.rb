Rails.application.routes.draw do
  resources :earnings, only: [:index, :new, :create, :show]
  resources :items, only: [:index, :new, :create, :show, :edit, :update]
  resources :charges, only: [:index, :new, :create, :show, :destroy]
  root to: 'items#index'
end
