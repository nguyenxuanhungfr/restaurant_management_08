Rails.application.routes.draw do
  root "static_pages#home"
  namespace :admin do
    root "static_pages#home"
  end
end
