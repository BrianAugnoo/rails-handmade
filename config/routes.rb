Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"

  resources :art do
    resources :comments, only: [ :index, :create, :destroy ]
    resources :likes, only: [ :create, :destroy ]
  end

  resources :notifications, only: [ :index, :destroy ]

  get "searchUser" => "search#search_user", as: :search_user
  
  resources :conversations, only: [ :index, :show ]

  post ":user_id/message" => "messages#create", as: :create_message
end
