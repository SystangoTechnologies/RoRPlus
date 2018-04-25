Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  mount API::Base => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
end
