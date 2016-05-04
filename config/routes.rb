Rails.application.routes.draw do


  resources :comments
  root 'sessions#new'

  get 'sessions/new'

  get 'home' => 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  resources :users do
    resources :events
    collection do
      get 'notifications'
      delete 'notification' => 'users#delete_notification', as: 'delete_notification'
    end
  end

  resources :users, :except => [:index] do
    resources :activities
  end

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :events, :except => [:edit] do
     resources :activities
  end

  post 'events/:id/attend' => 'events#attend', as: 'attend'
  post 'events/:id/unattend' => 'events#unattend', as: 'unattend'

  get '/users/:id/preferences' => 'users#user_prefs', as:'user_prefs'
  post '/users/:id/preferences' => 'users#user_prefs_create'
  get '/users/:id/preferences/new' => 'users#user_prefs_new', as:'user_prefs_new'


  get 'recommendations' => 'users#recommendations'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
