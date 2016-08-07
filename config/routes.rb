Rails.application.routes.draw do
  # user dashboard
  get '/' => 'users#show'
  # quest routes
  get '/quests' => 'quests#index'
  get '/quests/new' => 'quests#new'
  post '/quests' => 'quests#create'
  get '/quests/:id' => 'quests#show'
  get '/quests/:id/edit' => 'quests#edit'
  patch '/quests/:id' => 'quests#update'
  delete '/quests/:id' => 'quests#destroy'
  # activity routes

  # Authentication routes
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
end
