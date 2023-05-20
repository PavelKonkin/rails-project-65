# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    resources :bulletins
    # root 'bulletins#index'
    root 'home#index'
    namespace :admin do
      root 'home#index'
      resources :bulletins, only: %i[index show]
      resources :users, only: %i[index edit update]
      resources :categories, only: %i[index new create edit update destroy]
    end
  end
  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
  end

  scope module: :web do
    get :sessions, to: 'session#destroy'
  end
end
