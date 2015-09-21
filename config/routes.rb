Rails.application.routes.draw do
  root 'products#index'

  resources :brands, except: %i(show)
  resources :categories, except: %i(show)
  resources :stores, except: %i(show)
  resources :products, except: %i(show)
end
