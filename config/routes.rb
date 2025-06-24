Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"

  resources :art do
    resources :comments, only: [ :index, :new, :create, :destroy ]
    resources :likes, only: [ :create ]
  end

  delete "art/:art_id/like" => "likes#destroy", as: :destroy_like

  resources :notifications, only: [ :index, :destroy ]

  get "search_user" => "search#search_user", as: :search_user
  get "user_index" => "search#user_index", as: :user_index
  get "search" => "search#index", as: :search
  post "search" => "search#results", as: :search_results

  resources :conversations, only: [ :index, :show, :new, :create ]

  post "session/online" => "session#online", as: :online_session
  post "session/offline" => "session#offline", as: :offline_session

  post ":user_id/message" => "messages#create", as: :create_message

  get ":user_id/profile" => "profile#show", as: :profile
  get ":user_id/profile/feed" => "profile#feed", as: :feed
  get "profile/edit" => "profile#edit", as: :edit_profile
  post "profile" => "profile#update", as: :update_profile
  get "profile/settings" => "profile#settings", as: :settings
end
