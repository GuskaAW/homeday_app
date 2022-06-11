Rails.application.routes.draw do
  resources :appointments, only: [:create]

  resources :realtors, only: [] do
    member do
      resources :appointments, only: [] do
        collection do
          get 'past'
          get 'future'
        end
      end
    end
  end
end
