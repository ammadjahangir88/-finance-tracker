Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "user/registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'my_portfolio', to: "users#my_portfolio" 
  get 'search_stocks', to: 'stocks#search'
  resources :user_stocks, only: [:create,:destroy]

  resources :users, only: [:show]
  resources :friendships

  # Defines the root path route ("/")
  # root "articles#index"
    root "welcome#index"

  get  'my_friends', to: 'users#my_friends'
  get   'search_friends', to: 'users#search'
end
