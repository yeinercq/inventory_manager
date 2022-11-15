Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  resources :providers, except: [:show]
end
