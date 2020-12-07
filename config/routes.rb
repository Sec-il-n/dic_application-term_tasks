Rails.application.routes.draw do
  get 'sessions/new'
  get 'session/new'
  root to: 'tasks#index'
  resources :tasks
  resources :users
  resources :sessions, only:[:new, :create, :destroy]
end
