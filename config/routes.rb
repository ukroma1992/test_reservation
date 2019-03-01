Rails.application.routes.draw do
  root 'restaurants#index'

  resources :users, only: [:new, :create]

  resources :restaurants do
  	resources :reservations
	end

  resources :sessions, only: [:new, :create, :destroy]
end
