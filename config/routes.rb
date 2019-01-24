Rails.application.routes.draw do
  resource :sessions
  resources :users
  resources :pages

  root to: "pages#show"
end
