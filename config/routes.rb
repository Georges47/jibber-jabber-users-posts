Rails.application.routes.draw do

  get '/', to: 'posts#index'
  get '/:id', to: 'posts#show'
  post '/', to: 'posts#create'
  post '/:id/reply', to: 'posts#reply'

end
