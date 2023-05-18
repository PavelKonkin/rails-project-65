# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    resources :bulletins
    root 'bulletins#index'
  end
  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
  end

  scope module: :web do
    get :sessions, to: 'session#destroy'
  end
end
