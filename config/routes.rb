Rails.application.routes.draw do
  # admin
  namespace :admin do
    root to: "top#index"
    resource :session, only: [ :new, :create, :destroy ]
    resources :organisms, only: [ :destroy ]
  end
  
  root "top#index"
  get 'about', to: "top#about"
  get 'growth', to: "top#growth"
  resources :organisms, only: [ :show, :create ]
end
