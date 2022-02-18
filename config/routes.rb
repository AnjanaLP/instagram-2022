Rails.application.routes.draw do


  root 'static_pages#home'

  get 'users/show'
  get '/signup', to: 'users#new'
end
