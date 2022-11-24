Rails.application.routes.draw do
  get 'profiles/show'
  get 'profiles/new'
  get 'profiles/create'
  get 'profiles/edit'
  get 'profiles/update'
  root to: 'pages#home'
  get 'pages/home'
  get '/admin', to: redirect('users/sign_in')

  devise_for :users
  resource :profile, only: [:new, :show, :edit, :update ]
  resolve('Profile') { [:profile] }
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
