Rails.application.routes.draw do
  resources :brands, except: %i(show)
  resources :categories, except: %i(show)
  resources :stores, except: %i(show)
  resources :products, except: %i(show)

  root 'products#index'
end
