Rails.application.routes.draw do
  get 'profiles/new'
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  resources :profiles, only: %i[new create]
  resources :rooms, only: %i[index show new create]

  root to: 'pages#home'
end
