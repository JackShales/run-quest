Rails.application.routes.draw do

  # user dashboard
  get '/' => 'users#home'
  get '/users' => 'users#index'
  get 'users/:id' => 'users#show'
  get '/authorize' => 'users#authorize'
  # quest routes
  get '/quests' => 'quests#index'
  # get '/quests/new' => 'quests#new'
  post '/quests' => 'quests#create'
  get '/quests/:id' => 'quests#show'
  get '/quests/:id/edit' => 'quests#edit'
  patch '/quests/:id' => 'quests#update'
  delete '/quests/:id' => 'quests#destroy'
  # activity routes
  get '/activities' => 'activities#index'
  get '/activities/new' => 'activities#new'
  post '/activities' => 'activities#create'
  get '/activities/:id' => 'activities#show'
  get '/activities/:id/edit' => 'activities#edit'
  patch '/activities/:id' => 'activities#update'
  delete '/activities/:id' => 'activities#destroy'
  # friend routes
  get '/friends' => 'friends#index'
  post '/friends' => 'friends#create'
  patch '/friends/:id' => 'friends#update'

  # Authentication routes
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # API routes
  namespace :api do
    namespace :v1 do
      get '/activities' => 'activities#index'
      get '/activities/:id' => 'activities#show'

      get '/quests' => 'quests#index'
      get '/quests/:id' => 'quests#show'
    end
  end
end
