Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'relationships/followings'
  get 'relationships/followers'
  get 'pages/index'
  get 'pages/show'
  devise_for :users
  resources :profiles
  root 'profiles#index'
  resources :rooms, only: [:index, :create]
  resources :chats, only: [:index, :create, :show]

  resources :chatbots, only: [:index]
  resources :answers, only: [:new, :create]

  resource :favorites, only: [:create, :destroy, :show]

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
end
