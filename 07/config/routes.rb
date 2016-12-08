Rails.application.routes.draw do
  resources :faculties
  resources :theses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'theses#index'
end
