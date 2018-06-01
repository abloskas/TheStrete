Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '' => 'homes#index'

  get 'homes/show' => 'homes#show'

  get 'homes/map' => 'homes#map'

  get 'users' => 'users#index'

  post 'users/create' => 'users#create'

  post 'users/login' => 'users#login'

  post 'likes' => 'homes#likes'

  delete 'likes/:id' => 'homes#destroy'

  get 'logout' => 'users#logout'

  get 'users/:id' => 'users#show'
end
