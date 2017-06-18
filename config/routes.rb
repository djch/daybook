Rails.application.routes.draw do

  # Welcome
  root 'welcome#index'
  get  'welcome/index'
  get  '/about', to: 'welcome#about'

  # Users
  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get  '/forgot_password', to: 'password_resets#new'
  post '/forgot_password', to: 'password_resets#create'
  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]

  # Sessions
  get    '/sign_in',  to: 'sessions#new'
  post   '/sign_in',  to: 'sessions#create'
  delete '/sign_out', to: 'sessions#destroy'

  # Articles
  resources :articles do
    resources :comments
  end
end
