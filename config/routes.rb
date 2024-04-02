Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :areas, except: [:show, :destroy]
    resources :spots, except: [:destroy, :show]
    resources :genres, except: [:show, :destroy]
    resources :post_comments, only: [:index, :destroy]
  end
  scope module: :public do
    devise_for :users
    root to: 'homes#top'
    get "/homes/spot" => "homes#spot"
    post "/homes/guest_sign_in" => "homes#new_guest", as: "guest_sign_in"
    get "/users/withdrawal_confirm" => "users#withdrawal_confirm", as: "withdrawal_confirm"
    resources :users, only: [:show, :edit, :update, :destroy]
    resources :posts do
      resource :favorite, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
  end
end