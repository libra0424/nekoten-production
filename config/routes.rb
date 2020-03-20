Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  get '/users/:id', to: 'users#show', as: 'user'
end
