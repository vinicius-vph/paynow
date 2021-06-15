Rails.application.routes.draw do
  root 'home#index'

  devise_for :admins

  namespace :admin do
    root to: 'admin#index'
    resources :payment_methods
    resources :companies,  only: %i[index show edit update]
  end
end
