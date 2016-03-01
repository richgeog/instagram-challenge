Rails.application.routes.draw do

  devise_for :users
  root to: "photos#index"

  resources :users do
    resources :photos
  end

  resources :photos, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
    resources :comments, only: [:new, :create]
    resources :likes, only: [:create]
  end
end
