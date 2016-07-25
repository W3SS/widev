Rails.application.routes.draw do
  get 'chat/index'

  resources :release_items
  resources :reltypes
  resources :systems
  devise_for :users
  get 'hello_world', to: 'hello_world#index'
  get 'calendar/index'
  get 'monitor/index'

  get 'uploads/new'
  resources :uploads

  resources :releases
  get 'my_query/index'

  get 'my_query/show/:id'=> 'my_query#show'
  
  root to: "monitor#index"

  resources :queries
  resources :webservices
  
  mount Commontator::Engine => '/commontator'

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'monitor#index'

  # Example of regular route:
   get 'webservice/import' => 'webservices#import'
   post 'webservice/import' => 'webservices#import'


  get 'ritems/import' => 'release_items#import'
  post 'ritems/import' => 'release_items#import'
  
  get 'ritems/remove_all/:release' => 'release_items#remove_all'
  
  get 'release/objects/:id' => 'releases#viewobject'
  
  
  
  
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
  #     resources :comments
  #     resources :sales do
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
