Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  post '/homes/guest_sign_in' => 'homes#new_guest', as: "guest_sign_in"
  get "/users/withdrawal_confirm" => "users#withdrawal_confirm", as: "withdrawal_confirm"
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :posts
  resources :areas, except: [:show, :destroy]
  resources :spots, except: [:destroy]
end
