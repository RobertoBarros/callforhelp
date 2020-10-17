Rails.application.routes.draw do
  get 'tickets/new'
  get 'profiles/new'
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  resources :profiles, only: %i[new create]
  resources :rooms, only: %i[index show new create edit update] do
    resources :tickets, only: %i[new create]
  end

  resources :tickets, only: %i[destroy] do
    post 'assign_teacher', to: 'tickets#assign_teacher', on: :member
    post 'cancel', to: 'tickets#cancel', on: :member
    post 'solved', to: 'tickets#solved', on: :member
  end

  root to: 'pages#home'
end
