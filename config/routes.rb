Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  resources :rooms, only: %i[index show new create]

  root to: 'pages#home'
end
