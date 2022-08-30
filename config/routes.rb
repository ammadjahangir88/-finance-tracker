Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'my_portfolio', to: "users#my_portfolio" 
  get 'search_stocks', to: 'stocks#search'
  resources :user_stocks, only: [:create,:destroy]

  # Defines the root path route ("/")
  # root "articles#index"
    root "welcome#index"
end
