Rails.application.routes.draw do
  devise_for :users
  get "home/index"
  root "home#index"

  get "synchronisation/index"
  patch "synchronisation/synchronise_action"
end
