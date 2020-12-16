Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  post '/signout', to: 'sessions#destroy'
  
  resources :incomes
  resources :categories
  resources :expenses
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
