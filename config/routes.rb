Rails.application.routes.draw do
  devise_for :users
  get "home/index"

  patch "home/ajax_action"

  root "home#index"
end
