Rails.application.routes.draw do
  get 'home/welcome'
  get 'home/dashboard'
  resources :costs
  resources :booking_types
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :bookings do
    member do
      post 'pay'
      get 'failure'
      get 'success'
      get 'pending'
    end
  end
  post 'bookings/webhook', to: 'bookings#webhook'
  get 'providers/:id/services', to: 'booking_types#provider_services', as: 'provider_services'

  # Defines the root path route ("/")
  root "home#welcome"
end
