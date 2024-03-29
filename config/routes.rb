Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "application#index"
  resources :friends
  resources :users
  resources :posts
  resources :reactions
  resources :comments
  resources :notifications
  resources :friend_requests
  post 'update_notifications', to: 'notifications#update_notifications'
  post 'load_posts(:page)', to: 'posts#index'
  post 'users/:id(:page)', to: 'users#show'
end
