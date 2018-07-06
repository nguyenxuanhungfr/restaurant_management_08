Rails.application.routes.draw do
  root "static_pages#home"
  resources :users
  namespace :admin do
    root "static_pages#home"
  end
end
