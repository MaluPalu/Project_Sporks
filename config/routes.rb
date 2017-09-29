Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#index'

  resources :users, except: [:index]

  get '/users/:user_id/recipes/:recipe_id', to: 'users#recipes', as: 'user_recipes'

  resources :recipes do
    resources :reviews
  end


end
