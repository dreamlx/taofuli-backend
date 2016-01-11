Rails.application.routes.draw do
  root 'welcome#index'

  namespace :admin do
    get     'login'   => 'sessions#new'
    post    'login'   => 'sessions#create'
    delete  'logout'  => 'sessions#destroy'
    resources :admins
    root 'welcome#index'
  end
end
