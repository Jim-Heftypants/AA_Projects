# rails new first_project -d postgresql
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #change deletes to destroy 
  resources :users, only: [:index, :show, :update, :destroy, :create]
  resources :artworks, only: [:show, :update, :destroy, :create]
  #resources :artwork_shares, only: [:create, :destroy]
  post 'artwork_shares/', to: 'artwork_shares#create', as: ''
  delete 'artwork_shares/:id', to: 'artwork_shares#destroy', as: ''

  get 'users/:user_id/artworks', to: 'artworks#index', as: ''
  #get 'users/:user_id/favorited_art', to: '', as: ''

  resources :comments, only: [:index, :create, :destroy]
  resources :likes, only: [:index, :create, :destroy]
  resources :collections, only: [:index, :create, :destroy]

# get 'users/:id/favorite', to: 'users#favorite', as: 'favorite'
resources :users do
  member do
    get 'favorite', to: 'users#favorite', as: 'favorite'
  end
end

resources :artworks do
  member do
    get 'favorite', to: 'artworks#favorite', as: 'favorite'
  end
end

  # resources :users, except: [:new, :edit] do
  #   resources :artworks, only: [:index]
  # end

  # get 'users/', to: 'users#index', as: 'users'
  # post 'users/'  , to: 'users#create', as: ''  
  # get 'users/new', to: 'users#new', as: 'new_user'
  # get 'users/:id/edit', to: 'users#edit', as: 'edit_user'
  # get '/users/:id', to: 'users#show', as: 'user'
  # patch '/users/:id', to: 'users#update', as: ''
  # put '/users/:id', to: 'users#update', as: ''
  # delete '/users/:id', to: 'users#delete', as: ''

end
