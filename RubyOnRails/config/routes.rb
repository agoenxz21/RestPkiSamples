Rails.application.routes.draw do

  root :to => "home#index"

  resources :authentications
  resources :pades_signatures

  get '/upload', to: 'pades_signatures#upload'
  post '/upload', to: 'pades_signatures#sign_upload'

end
