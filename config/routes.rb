Rails.application.routes.draw do
  root 'drawings#index'
  patch 'drawable/:id', to: 'drawings#drawable', as: 'drawable'
  resources :drawings
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
