Rails.application.routes.draw do

  devise_for :users
root to: "photos#index"

  resources :users do
    resources :photos
  end

  resources :photos do
    resources :comments, :likes
  end

end
