Rails.application.routes.draw do
  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    get 'subject/:subject_id/:subject', to: 'search#subject', as: 'search_subject'
    post 'answer', to: 'answer#question'
  end

  namespace :admins_backoffice do
    get 'welcome/index' # Dashboard
    resources :admins
    resources :subjects
    resources :questions
  end

  namespace :users_backoffice do
    get 'welcome/index'
    get 'profile', to: 'profile#edit'
    patch 'profile', to: 'profile#update'
    get 'zip_code', to: 'zip_code#show'
  end

  devise_for :admins, skip: [:registration]
  devise_for :users

  get 'backoffice', to:'admins_backoffice/welcome#index'

  root to: 'site/welcome#index'
end
