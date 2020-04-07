Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users,
    controllers: { registrations: 'registrations' } #パスワードなしでアカウント情報の変更を許可
  get '/users/:id', to: 'users#show', as: 'user'
  resources :posts, only: %i(new create) do
    resources :photos, only: %i(create)
  end
end
