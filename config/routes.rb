Rails.application.routes.draw do
  root to: "pages#home"
  get '/answer', to: 'pages#answer'
  resources :points_of_interests, only: [:index], on: :collection

 

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
