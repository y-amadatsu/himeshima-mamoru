Rails.application.routes.draw do
  namespace :reservations do
    get 'imports/new', to: 'imports#new'
    post 'imports', to: 'imports#create'
  end

  resources :reservations do
    collection do
      get 'export', to: 'reservations#export'
    end
  end

  root 'dashboard#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :users
end
