Rails.application.routes.draw do

  get '/coffees' => 'coffees#index'
  get '/coffees/:id' => 'coffees#show'

  post '/coffees' => 'coffees#create'

  get '/coffees/:id/edit' => 'coffees#edit'
  patch '/coffees/:id' => 'coffees#update'
  delete '/coffees/:id' => 'coffees#destroy'

end
