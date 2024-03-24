Rails.application.routes.draw do
  devise_for :owners, controllers: {
    sessions: 'owners/sessions',
    registrations: 'owners/registrations'
  }
  root to: 'home#index'

  resources :restaurants, except: [:destroy] do
    post 'inactive', on: :member
    post 'active', on: :member
  end
end
