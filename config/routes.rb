Rails.application.routes.draw do
  root "static_pages#home"
  resources :users
  resources :menus
  resources :dishes
  namespace :admin do
    root "static_pages#home"
  end
end
