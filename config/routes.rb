Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
  end
  get 'sessions/new'
  get 'session/new'
  root to: 'tasks#index'
  resources :tasks
  resources :users
  resources :sessions, only:[:new, :create, :destroy]
  namespace :admin do
    resources :users
  end
end
