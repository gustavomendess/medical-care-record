Rails.application.routes.draw do
  root to: 'appointments#index'
  resources :dashboards, only: [:index, :show]
  resources :doctors
  resources :patients
  resources :appointments
end
