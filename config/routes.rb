Rat::Application.routes.draw do
  get "admin/users/show", to: "admin/users#show", as: "admin_show_users"
  get "admin/users/new", to: "admin/users#new", as: "admin_new_user"
  post "admin/users/create", to: "admin/users#create", as: "admin_create_user"
  get "admin/users/edit/:id", to: "admin/users#edit", as: "admin_edit_user"
  put "admin/users/update/:id", to: "admin/users#update", as: "admin_update_user"
  delete "admin/users/:id", to:"admin/users#destroy", as: "admin_delete_user"
  get "admin/users/toogle_lock/:id", to: "admin/users#toogle_locking", as: "admin_toogle_lock"

  get "password/edit"
  get "password/update"

  resources :categories
  resources :companies

  #status updates
  get 'tasks/:id/new_status', to: "tasks#new_status", as: "new_task_status"
  post 'tasks/:id/new_status', to: "tasks#create_status", as: "new_task_status"
  get 'tasks/:id/edit_status/:status_id', to: "tasks#edit_status", as: "edit_task_status"
  put 'tasks/:id/update_status/:status_id', to: "tasks#update_status", as: "update_task_status"
  get 'tasks/:id/history', to: "tasks#history", as: "task_history"
  post 'tasks/:id/complete_current', to: "tasks#complete_current", as:"task_complete_current"

  mount Ckeditor::Engine => '/ckeditor'

  resources :tasks

  devise_for :users

  get "user/password/edit", to: "deviser/password#edit", as: "change_password"
  put "user/password/update", to: "deviser/password#update", as: "update_password"

  get "home/index"

  get "agenda/(:start_date)", to: "agenda#index", as: :agenda
  post "agenda/(:start_date)", to: "agenda#index", as: :agenda

  root :to => "home#index"

  # mount Ckeditor::Engine => "/ckeditor"

  #match "*path", :to => "home#routing_error"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
