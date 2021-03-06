Rails.application.routes.draw do
  resources :categories
  resources :transactions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#profile'

  resources :users, only: %i[index create destroy edit update]
  get 'signup', to: 'users#new', as: 'signup'
  get 'transactions_sort', to: 'transactions#index_sort', as: 'sort_transactions'
  get 'sort_external_transactions', to: 'transactions#external_index_sort', as: 'sort_external_transactions'
  get 'external_transactions', to: 'transactions#external_index', as: 'external_transactions'
  get 'external_transactions/new', to: 'transactions#new_external', as: 'new_external_transaction'
  post 'external_transactions/new', to: 'transactions#create_external'
  get 'categories/(:id)/new', to: 'categories#new_transaction', as: 'new_categorized_transaction'
  post 'categories/(:id)/new', to: 'categories#create_transaction', as: 'create_categorized_transaction'

  post 'add_category', to: 'transactions#add_category'
  delete 'remove_category', to: 'transactions#remove_category'
  get 'welcome', to: 'sessions#welcome'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
end
