Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'application#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  post '/signout', to: 'sessions#destroy'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/expenses/most_recent' => 'expenses#most_recent'
  resources :users, only: [:create, :show] 
  resources :accounts
  resources :categories
  resources :expenses

  resources :accounts do
    resources :expenses
  end

end

