Rails.application.routes.draw do
  root 'home#index'
  
  devise_for :admins
  devise_for :clients
  
  namespace :admin do
    root to: 'admin#index'
    resources :payment_methods
    resources :companies,  only: %i[index show edit update] do
      put 'update_token', on: :member
    end
  end

  get 'register', to: 'home#register' 
  get 'register/companies', to: 'home#new_register_companies' 
  post 'register/companies', to: 'home#create_register_companies' 
  get 'register/clients', to: 'home#new_register_clients' 
  post 'register/clients', to: 'home#create_register_clients' 
end
