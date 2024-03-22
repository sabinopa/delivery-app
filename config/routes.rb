Rails.application.routes.draw do
  devise_for :owners, controllers: {
    sessions: 'owners/sessions',
    registrations: 'owners/registrations'
  }
  root to: 'home#index'

  resources :restaurants, only: [:new, :create, :show, :edit, :update]

end
