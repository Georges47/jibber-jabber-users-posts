Rails.application.routes.draw do

  get '/', to: 'posts#index'
  get '/:id', to: 'posts#show'
  get '/users/:id/posts', to: 'posts#user_posts'
  post '/', to: 'posts#create'
  post '/:id/reply', to: 'posts#reply'
  delete '/:id', to: 'posts#destroy'

  get '/users/:id', to: 'users#show'
  post '/users', to: 'users#check_user'

end
