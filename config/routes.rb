Rails.application.routes.draw do
  root to: 'pages#home'
  get 'pages/home'
  get '/admin', to: redirect('users/sign_up')
  devise_for :users
  resources :providers, except: [:show]
  resources :customers
  resources :products do
    resources :movements, only: [:new, :create, :index]
    resources :sale_prices, only: [:new, :create, :edit, :update]
  end
  resources :sales do
    patch :trigger, on: :member
    resources :items, except: [:show, :index]
  end
end
