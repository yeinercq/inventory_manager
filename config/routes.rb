Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  resources :providers, except: [:show]
  resources :customers
  resources :products do
    resources :movements, only: [:new, :create, :index]
  end
  resources :sales do
    patch :trigger, on: :member
    resources :items, except: [:show, :index]
  end
end
