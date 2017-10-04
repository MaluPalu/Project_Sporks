Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#index'

  resources :users do
    put :follow, on: :member
  end

  get '/users/:id/recipes', to: 'users#recipes', as: 'user_recipes'
  get '/users/:id/reviews', to: 'users#reviews', as: 'user_reviews'
  get '/users/:id/favorites', to: 'users#favorites', as: 'user_favorites'
  get '/users/:id/followings', to: 'users#followings', as: 'user_followings'
  get '/users/:id/fridge', to: 'users#fridge', as: 'user_fridge'

  resources :recipes do
    put :favorite, on: :member
    collection do
      get :autocomplete
    end
    resources :reviews
  end
end
