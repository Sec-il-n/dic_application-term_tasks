Rails.application.routes.draw do
  # namespace :admin do
  #   get 'users/index'
  # end
  root to: 'tasks#index'
  resources :tasks
  resources :users
  resources :labels, only:[:new, :create, :show, :index] do
    collection do
      post :confirm
    end
  end
  resources :sessions, only:[:new, :create, :destroy, :index]
  resources :groups
  resources :user_groups, only:[:create, :destroy, :index]
  # resources :managers, only:[:index, :create, :destroy]
  namespace :admin do
    resources :users
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
