Rails.application.routes.draw do
  root to: 'appointments#index'
  get 'dashboards/search', to: 'dashboards#search', as: :search_dashboards
  resources :dashboards, only: [:index]
  resources :doctors
  resources :patients
  resources :appointments
end
