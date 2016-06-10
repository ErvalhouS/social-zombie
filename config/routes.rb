Rails.application.routes.draw do
  post '/items/exchange' => 'item#exchange'
  post '/items/inventory' => 'item#inventory'
  get '/reports/infected_survivors' => 'report#infected_survivors'
  get '/reports/healthy_survivors' => 'report#healthy_survivors'
  get '/reports/average_resource' => 'report#average_resource'
  get '/reports/loss_by_infection' => 'report#loss_by_infection'

  get '/survivors' => 'survivor#index', as: 'survivor'
  get '/survivors/show/:id' => 'survivor#show'
  post '/survivors/create' => 'survivor#create'
  patch '/survivors/update/:id' => 'survivor#update'
  put '/survivors/update/:id' => 'survivor#update'
  delete '/survivors/:id' => 'survivor#destroy'
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
