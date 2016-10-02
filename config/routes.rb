Rails.application.routes.draw do
  get 'welcome/index'
  get 'welcome/about'

  resources :articles do
    resources :comments
  end

  root 'welcome#index'
end
