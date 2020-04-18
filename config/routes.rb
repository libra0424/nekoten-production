# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_out', to: 'users/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root 'posts#index'

  get '/pages/home', to: 'pages#home'
  resources :posts, only: %i[new create index show destroy] do
    resources :photos, only: %i[create]
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
  end

  get '/users/:id', to: 'users#show', as: 'user'

  resources :cats, only: %i[new create index show destroy]
end
