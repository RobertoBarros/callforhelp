Rails.application.routes.draw do
  get 'tickets/new'
  get 'profiles/new'
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  resources :profiles, only: %i[new create]
  resources :rooms, only: %i[index show new create] do
    resources :tickets, only: %i[new create]
  end

  root to: 'pages#home'
end
