Rails.application.routes.draw do
  namespace :admins_backoffice do
    get 'welcome/index' # Dashboard
    resources :admins
    resources :subjects
    resources :questions
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
