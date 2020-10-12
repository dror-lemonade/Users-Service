Rails.application.routes.draw do
  resources :users

  post '/users/sign_in', to: 'users#sign_in'
  post '/users/sign_out', to: 'users#sign_out'
  put '/users/:id', to: 'users#update'
end
