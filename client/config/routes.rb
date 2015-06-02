 Rails.application.routes.draw do

  resources :comments
  get 'account_activations/edit'

  resources :generate_dares
  resources :charities, only: [:show, :index]
  resources :pending_dares, only: :show

  resources :users do
    resources :dares
    resources :relationships, only: [:create, :destroy, :index]
  end

  resources :account_activations, only: [:edit]

  root 'users#home'

  get '/feed' => 'users#feed', as: :feed

  get '/home' => 'users#home'
  get '/about' => 'users#about'
  post '/login' => 'users#login'
  match "/auth/:provider/callback" => "sessions#create", via: [:get, :post]
  get "/signout" => "sessions#destroy", as: :signout


  get '/generate' => "generate_dares#generate", as: :generate

  get '/users/:user_id/dares/:id/set_price' => 'dares#set_price', as: :set_price
  patch '/users/:user_id/dares/:id/set_price' => 'dares#put_price', as: :put_price

  get '/dares/:dare_id/video/new' => 'videos#new', as: :new_video
  post '/dares/:dare_id/video' => 'videos#create', as: :dare_videos

  get '/dares/:dare_id/donations/:id/pay' => 'donations#pay', as: :pay_donations
  post '/dares/:dare_id/donations/:id/pay' => 'donations#paid'
  get '/dares/:dare_id/donations/new' => 'donations#new', as: :new_donation
  post '/dares/:dare_id/donations' => 'donations#create', as: :donations

  get '/users/invite/:handle' => "users#new_invite"
  post '/user/invites' => "users#invite", as: :user_invite

  get '/check_handle/:handle' => "users#check", as: :check

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
