PumaApp::Application.routes.draw do
  resources :authors do
    collection do
      post 'sort'
    end
  end

  resources :emails
  resources :notes
  resources :target_journals
  resources :variables
  resources :focus_groups
  resources :country_teams
  resources :populations
  resources :publication_types
  resources :surveys
  resources :languages
  resources :pages
  # resources :publications

  resources :publications do
    collection do
      get 'list'
      post 'import'
    end
    member do 
      put 'preplanned_submit'
      put 'preplanned_accept'
      put 'preplanned_reject' 
      put 'preplanned_remind'
      put 'planned_submit'
      put 'planned_accept'
      put 'planned_reject' 
      put 'planned_remind'
      put 'inprogress_submit'  
      put 'inprogress_accept'
      put 'inprogress_reject' 
      put 'inprogress_remind'
      put 'submitted_submit'  
      put 'submitted_accept'
      put 'submitted_reject'
      put 'submitted_remind'
      put 'accepted_submit'  
      put 'accepted_accept'
      put 'accepted_reject'
      put 'accepted_remind'
      put 'preplanned_removal_request'
      put 'planned_removal_request'
      put 'inprogress_removal_request'
      put 'submitted_removal_request'
      put 'accepted_removal_request'
      put 'published_removal_request'
      put 'removal_accept'
      put 'preplanned_removal_reject'
      put 'planned_removal_reject'
      put 'inprogress_removal_reject'
      put 'submitted_removal_reject'
      put 'accepted_removal_reject'
      put 'published_removal_reject'
      put 'unlock'
      put 'archive'
      put 'unarchive'
      get 'audit'
    end
  end


  devise_for :users
  resources :users

  root to: 'pages#home'
  match '/about',     to: 'pages#about'
  match '/contact',   to: 'pages#contact'
  match '/master',    to: 'pages#master' 
  match '/no_access', to: 'pages#no_access' 


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
