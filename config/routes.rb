Rails.application.routes.draw do

  root "users#show"

  get 'users/show'
end
