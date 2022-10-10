Rails.application.routes.draw do
  get 'home/welcome'
  get 'home/dashboard'
  get 'checkout', to: 'checkouts#show'
  get 'checkout/success', to: 'checkouts#success'
  get 'billing', to: 'billing#show'
  resources :costs
  resources :booking_types
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :bookings do
    member do
      post 'mercadopago_payment'
      post 'stripe_payment'
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
