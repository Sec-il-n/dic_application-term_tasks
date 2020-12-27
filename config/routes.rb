Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
  end
  root to: 'tasks#index'
  resources :tasks
  resources :users
  resources :labels, only:[:new, :create, :show] do
    collection do
      post :confirm
    end
  end
  resources :sessions, only:[:new, :create, :destroy]
  # resources :managers, only:[:index, :create, :destroy]
  namespace :admin do
    resources :users
  end
end
