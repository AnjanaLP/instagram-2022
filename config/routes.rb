Rails.application.routes.draw do
  root 'pages#home'

  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :posts, except: [:index]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :posts do
    resources :comments, only: [:create]
  end
  resources :posts do
    resources :likes, only: [:create]
    member do
      get :likes
    end
  end
end
