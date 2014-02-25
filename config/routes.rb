Forum::Application.routes.draw do

#defined in lib
require 'api_constraints'

scope "(:locale)", locale: /en|sv/ do

# This method, you need to call like this: api/v1/posts or api/v2/posts
# Currently it’s in the URL path which is simple and direct but which isn’t considered a best practice by some.
# Github, for example, made a change so that instead of including the version number in the URL it’s passed in an Accept header

#namespace :api do
#  namespace :v1 do
#    resources :post_votes
#    resources :posts
#  end
#end


#namespace :api do
#    namespace :v2 do
#      resources :posts
#    end
#end


#This method, you just call api/posts , and in the headers you have an accept parameter set to: application/vnd.example.v1  for version 1. Default is last version
namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
        resources :post_votes
        resources :posts
        resources :comment_votes
        resources :comments
        resources :post_flags
    end
    scope module: :v2, constraints: ApiConstraints.new(version: 2) do #, default: :true
        resources :posts
    end
end


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
end
