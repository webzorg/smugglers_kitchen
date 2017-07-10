Rails.application.routes.draw do
  devise_for :users
  get "home/index"
  root "home#index"

  get "synchronisation/index"
  patch "synchronisation/synchronise_action"

  get "analytics/index"
  patch "analytics/select_preseller_action"
  patch "analytics/select_contractor_action"

  resources :trading_agents, only: [:index, :edit, :update]
end
