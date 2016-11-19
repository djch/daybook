Rails.application.routes.draw do

  root 'welcome#index'
  get  'welcome/index'
  get  '/about', to: 'welcome#about'

  get  '/signup', to: 'users#new'

  resources :articles do
    resources :comments
  end

end
