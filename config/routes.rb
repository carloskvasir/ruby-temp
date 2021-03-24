Rails.application.routes.draw do
  namespace :admins_backoffice do
    resources :admins, only: [:index]
    get 'welcome/index' # Dashboard
  end
  namespace :site do
    get 'welcome/index'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end
  devise_for :admins
  devise_for :users

  root to: 'site/welcome#index'
end
