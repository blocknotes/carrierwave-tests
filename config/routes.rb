Rails.application.routes.draw do
  resources :news
  resources :posts

  root 'posts#index'
end
