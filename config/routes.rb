Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/rswag/api-docs', via: [:get]
  mount Rswag::Api::Engine => '/rswag/api-docs', via: [:get]

  get '/', to: 'posts#index'
  get '/:id', to: 'posts#show'
  post '/', to: 'posts#create'
  post '/:id/reply', to: 'posts#reply'
  delete '/:id', to: 'posts#destroy'

end
