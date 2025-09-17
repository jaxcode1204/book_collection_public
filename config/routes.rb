Rails.application.routes.draw do
  resources :user_books
  resources :users
  resources :books
  root to: "user_books#index"

  get "home/index", to: "home#index", as: :home_index
  match "home/add", to: "home#add", via: [:get, :post], as: :home_add
  get "home/delete/:id", to: "home#delete", as: :home_delete
  get "home/details/:id", to: "home#details", as: :home_details
  get "home/update/:id", to: "home#update", as: :home_update 



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :books, only: [:create, :update, :destroy] 

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # Defines the root path route ("/")
  # root "posts#index"
end
