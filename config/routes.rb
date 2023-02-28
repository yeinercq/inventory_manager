Rails.application.routes.draw do
  root to: 'pages#home'
  get 'pages/home'
  get '/admin', to: redirect('users/sign_in')

  devise_for :users
  resource :profile, only: [:new, :create, :show, :edit, :update ]
  resolve('Profile') { [:profile] }
  resources :providers, except: [:show]
  resources :customers
  resources :products do
    resources :movements, only: [:new, :create, :index] do
      collection do
        get :options
      end
    end
    resources :sale_prices, only: [:new, :create, :edit, :update]
  end
  resources :categories, except: [:show]
  resources :exports, only: [:new, :create, :index]
  resources :wallets, except: [:destroy] do
    resources :transactions, only: [:create] do
      get 'deposit', on: :member
      get 'withdraw', on: :member
      get 'transfer', on: :member
      get 'expense', on: :member
    end
  end
  resources :general_settings, only: [:new, :create, :edit, :update]
  resources :locations do
    resources :sales, except: :index do
      patch :trigger, on: :member
      resources :items, except: [:show, :index]
    end

    resources :coffee_purchases, except: :index do
      patch :trigger, on: :member
    end
  end
end
