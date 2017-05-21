Rails.application.routes.draw do

  # Welcome
  root 'welcome#index'
  get  'welcome/index'
  get  '/about', to: 'welcome#about'

  # Users
  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users

  # Sessions
  get    '/sign_in',  to: 'sessions#new'
  post   '/sign_in',  to: 'sessions#create'
  delete '/sign_out', to: 'sessions#destroy'

  # Articles
  resources :articles do
    resources :comments
  end
end
