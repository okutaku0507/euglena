Rails.application.routes.draw do
  root "top#index"
  get 'about', to: "top#about"
  get 'growth', to: "top#growth"
  resources :organisms, only: [ :show ]
end
