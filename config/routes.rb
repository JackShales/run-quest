Rails.application.routes.draw do

  # user dashboard
  get '/' => 'users#home'
  get '/users' => 'users#index'
  get '/users/:id/' => 'users#show'
  get '/authorize' => 'users#authorize'
  # quest routes

  get '/inbox/pending' => 'quests#in_pending'
  get '/inbox/active' => 'quests#in_active'
  get '/inbox/complete' => 'quests#in_complete'

  get '/outbox/pending' => 'quests#out_pending'
  get '/outbox/active' => 'quests#out_active'
  get '/outbox/complete' => 'quests#out_complete'

  get '/quests' => 'quests#index'
  # get '/quests/new' => 'quests#new'
  post '/quests' => 'quests#create'
  get '/quests/:id/' => 'quests#show'
  get '/quests/:id/edit' => 'quests#edit'
  patch '/quests/:id' => 'quests#update'
  delete '/quests/:id' => 'quests#destroy'
  # activity routes
  get '/activities' => 'activities#index'
  get '/activities/new' => 'activities#new'
  post '/activities' => 'activities#create'
  post '/activities/manual' => 'activities#create_manual'
  get '/activities/:id/' => 'activities#show'
  get '/activities/:id/edit' => 'activities#edit'
  patch '/activities/:id/' => 'activities#update'
  delete '/activities/:id/' => 'activities#destroy'
  # friend routes
  get '/friends' => 'friends#index'
  post '/friends' => 'friends#create'
  patch '/friends/:id/' => 'friends#update'

  # Authentication routes
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # Datapoints

  # API routes
  namespace :api do
    namespace :v1 do
      get '/activities' => 'activities#index'
      get '/activities/:id/' => 'activities#show'

      get '/quests' => 'quests#index'
      get '/quests/:id/' => 'quests#show'

      get '/users' => 'users#index'
      get '/users/:id' => 'users#show'
    end
  end
end
