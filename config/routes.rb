Rails.application.routes.draw do
  root "places#index"
  resources :places, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
