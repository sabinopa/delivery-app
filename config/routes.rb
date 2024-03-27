Rails.application.routes.draw do
  devise_for :owners, controllers: {
    sessions: 'owners/sessions',
    registrations: 'owners/registrations'
  }
  root to: 'home#index'

  resources :restaurants, shallow: true, except: [:destroy] do
    post 'inactive', on: :member
    post 'active', on: :member
    resources :menus, only: [:new, :create, :index, :show] do
      resources :items, only: [:new, :create]
    end
  end
end
