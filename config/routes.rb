Rails.application.routes.draw do
  devise_for :admin
  root 'home#index'

  devise_for :users

  mount API::Base => '/api'
  mount GrapeSwaggerRails::Engine => '/swagger'

  resources :users , only: [:show]

  namespace :admin do
    resources :dashboard , only: [:index]
    resources :admins, only: [], path: '' do
      get :change_password
      patch :update_password
    end
  end

end
