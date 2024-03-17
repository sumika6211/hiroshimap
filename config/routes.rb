Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "/homes/spot" => "homes#spot"
  get "/homes/area" => "homes#area"
  get "/homes/genre" => "homes#genre"
  post "/homes/guest_sign_in" => "homes#new_guest", as: "guest_sign_in"
  get "/users/withdrawal_confirm" => "users#withdrawal_confirm", as: "withdrawal_confirm"
  resources :users, only: [:show, :edit, :update, :destroy]do
    member do
      get :favorites
    end
  end
  resources :posts do
    resource :favorite, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  resources :areas, except: [:show, :destroy]
  resources :spots, except: [:destroy, :show]
  resources :genres, except: [:show, :destroy]
end