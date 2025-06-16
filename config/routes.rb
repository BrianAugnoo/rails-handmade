Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"

  resources :art do
    resources :comments, only: [ :index, :create, :destroy ]
    resources :likes, only: [ :create, :destroy ]
  end

  resources :notifications, only: [ :index, :destroy ]

  get "search_user" => "search#search_user", as: :search_user
  get "user_index" => "search#user_index", as: :user_index

  resources :conversations, only: [ :index, :show, :new, :create ]
  
  post "session/online" => "session#online", as: :online_session
  post "session/offline" => "session#offline", as: :offline_session

  post ":user_id/message" => "messages#create", as: :create_message
end
