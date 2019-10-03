Rails.application.routes.draw do
  devise_for :users
  get "/renewals/policy_index_renew", to: "renewals#policy_index_renew"
  resources :renewals
  resources :insurance_policies
  resources :customers
  root "customers#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
