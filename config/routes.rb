Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations' } #パスワードなしでアカウント情報の変更を許可
  
  root 'posts#index'

  get '/users/:id', to: 'users#show', as: 'user'
  get '/pages/home', to: 'pages#home'
  resources :posts, only: %i(new create index show) do
    resources :photos, only: %i(create)
  end
end
