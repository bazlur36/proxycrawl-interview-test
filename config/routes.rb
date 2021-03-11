Rails.application.routes.draw do
  namespace :api do
    resources :products, only: [:create, :show, :update, :destroy]
  end
end
