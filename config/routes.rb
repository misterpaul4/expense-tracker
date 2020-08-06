Rails.application.routes.draw do
  resources :expenses
  resources :transactions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#profile'

  resources :users, only: %i[index create destroy edit update]
  get 'signup', to: 'users#new', as: 'signup'
  get 'transactions_sort', to: 'transactions#index_sort', as: 'sort_transactions'
  get 'welcome', to: 'sessions#welcome'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
end
