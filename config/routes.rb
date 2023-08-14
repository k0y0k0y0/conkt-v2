Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'relationships/followings'
  get 'relationships/followers'
  get 'pages/index'
  get 'pages/show'

  #ログイン/ゲストログイン
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/admin_guest_sign_in', to: 'users/sessions#admin_guest_sign_in'
  end

  resources :profiles

  root 'pages#index'
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
