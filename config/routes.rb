Rails.application.routes.draw do
  resources :rtc_infos

  get 'my_rtc_infos/edit_my'=> 'rtc_infos#edit_my'
  post 'my_rtc_infos/update_my'=> 'rtc_infos#update_my'


  namespace :api do
  get 'rtc/updateWorkItemByInstallation'
  end

   namespace :api do
    get 'jenkins/runjob/:item_id' => 'jenkins#runjob'
    get 'jenkins/jobinfo/:item_id'=> 'jenkins#jobinfo'
    get 'jenkins/joblog/:item_id'=> 'jenkins#joblog'
    get 'jenkins/getbuildurl/:item_id'=> 'jenkins#getbuildurl'

   end


  get 'jenkins_test/joblist'

  get 'jenkins_test/jobstart'

  get 'rtc/index'

  get 'rtc/get'

  resources :databases
  resources :check_results
  namespace :check do
  get 'my_check/start'
  get 'my_check/viewjob'
  get 'my_check/viewresults'
  get 'my_check/executeonce'
  get 'my_check/resultdetail'
  end

  namespace :check do
  get 'my_check/stop'
  end

  namespace :check do
  get 'my_check/pause'
  end

  resources :query_checks
  get 'my_environment/status'

  get 'my_environment/history'

  get 'my_environment/info'
  get 'my_environment/home'

  namespace :api do
  get 'template/getavailablesteps'
  end

  namespace :api do
  get 'template/getstepfortemplate/:id'=> 'template#getstepfortemplate'
  end

  namespace :api do
  get 'template/addsteptotemplate'
  end

  namespace :api do
  get 'template/removestepfromtemplate'
  end

  namespace :api do
    get 'installation/startTask/:id'  => 'installation#startTask'
    get 'installation/endTask/:id'  => 'installation#endTask'
    get 'installation/errorTask/:id'   => 'installation#errorTask'
    get 'installation/setnaTask/:id'   => 'installation#setnaTask'
    get 'installation/complete/:id'   => 'installation#complete'
    post 'installation/additem'   => 'installation#additem'
  end



  resources :environments
  get 'my_installation/newinstall'
  get 'my_installation/viewinstall/:id' => 'my_installation#viewinstall'
  get 'my_installation/ongoing'
  get 'my_installation/testview/:id' => 'my_installation#testview'

  post 'my_installation/createinstall'

  resources :item_per_installations
  resources :installations
  resources :rel_template_items
  resources :rel_templates
  get 'chat/index'

  resources :release_items
  resources :reltypes
  resources :systems
  devise_for :users
  get 'hello_world', to: 'hello_world#index'
  get 'calendar/index'
  get 'monitor/index'

  post 'release_items/:id/toggle' => 'release_items#toggle'

  get  'utils/release_items/export' => 'release_items#export'

  get 'uploads/new'
  resources :uploads

  resources :releases
  get 'my_query/index'

  get 'my_query/show/:id'=> 'my_query#show'
  
  root to: "monitor#index"

  resources :queries
  resources :webservices
  
  mount Commontator::Engine => '/commontator'

  telegram_webhooks TelegramController

  
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
