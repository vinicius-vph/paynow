Rails.application.routes.draw do
  root 'home#index'

  devise_for :admins

  namespace :admin do
    root to: 'admin#index'
    resources :payment_method, only: %i[new create]
  end
end
