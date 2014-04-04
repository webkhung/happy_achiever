Secret2::Application.routes.draw do

  #devise_for :users
  devise_for :users, :controllers => { :registrations => 'users' }

  devise_scope :user do
    get "users/:id" => "users#show"
    delete "users/:id" => "users#destroy"
    get 'users/:id/email' => 'users#email', as: 'email_user'
  end

  get "page/home"
  get "how-it-works" => 'page#how_it_works', as: 'how_it_works_page'
  get 'users/:id' => 'users#show', as: 'user'
  get "journal" => 'page#journal', as: 'journal'

  resources :schedules, :only => [:index, :new, :create, :edit, :destroy, :update]

  resources :goals

  resources :achievements, :except => [:destroy] do
    put 'support' => 'achievements#support', :on => :member

    resources :comments
    resources :lessons
    resources :gratefuls, :only => [:index, :new, :create]
    resources :empowerments, :only => [:new, :create]
  end

  resources :lessons, only: [:index]

  resources :tasks do
    resources :achievements
  end

  resources :milestones, :only => [:edit, :destroy, :update, :show]

  resources :focus_areas, :only => [:edit, :destroy, :update, :show] do
    resources :tasks
  end


  resources :plans do
    put 'support' => 'plans#support', :on => :member #don't use 'post' because post means create a new model (like a new focus area under plan).  This resolved to plan_support POST   /plans/:plan_id/support(.:format).  Noticed :plan_id is wrong.  Should use put (means edit)

    resources :comments
    resources :tasks
    resources :focus_areas, :only => [:index, :new, :create, :update]
    resources :milestones, :only => [:index, :new, :create]
  end

  resources :comments

  root :to => 'page#home'

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
