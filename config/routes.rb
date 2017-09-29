Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#index'

  resources :users, except: [:index]

  get '/users/:user_id/recipes', to: 'users#recipes', as: 'user_recipes'
  get '/users/:user_id/reviews', to: 'users#reviews', as: 'user_reviews'

  resources :recipes do
    resources :reviews
  end


end
