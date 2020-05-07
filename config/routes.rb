Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  
  # Webhooks routes
  mount StripeEvent::Engine, at: "/webhooks/stripe"



  # ImageUploader routes
  case Rails.configuration.upload_server
  when :s3
    # By default in production we use s3, including upload directly to S3 with
    # signed url.
    mount Shrine.presign_endpoint(:cache) => "/s3/params"
  when :s3_multipart
    # Still upload directly to S3, but using Uppy's AwsS3Multipart plugin
    mount Shrine.uppy_s3_multipart(:cache) => "/s3/multipart"
  when :app
    # In development and test environment by default we're using filesystem storage
    # for speed, so on the client side we'll upload files to our app.
    mount Shrine.upload_endpoint(:cache) => "/upload"
  end
  mount ImageUploader.derivation_endpoint => "/derivations/image"



  # Internationalization support
  # scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  #   -> all routes here <-
  # end



  ## Users Controller -> Devise
  devise_for :users, path: 'me', path_names: {sing_in: "sign_in", sing_out: "sign_out", sing_up: "sign_up", edit: "settings"}, :controllers => {
    :registrations            => "users/registrations",
    :confirmations            => "users/confirmations",
    :invitations              => "users/invitations",
    # :omniauth_callbacks       => "sellers/omniauth_callbacks",
    :passwords                => "users/passwords",
    :sessions                 => "users/sessions",
    :unlocks                  => "users/unlocks"
  }
  devise_scope :user do
    get 'me/settings/preferences', to: 'users/registrations#preferences', as: :edit_user_preferences
    get 'me/settings/security', to: 'users/registrations#security', as: :edit_user_security
    get 'me/settings/activity', to: 'users/registrations#activity', as: :edit_user_activity

    get 'user/favorites', to: 'users/registrations#favorites', as: :favorite_user

    resources :user_locations, path: "user/settings/addresses", as: :user_locations, module: :users
    # match 'user/settings/profile'      => 'users/registrations#edit', via: :get, :as => :user_profile # default Devise edit page
    # match 'user/settings/payments'     => 'users/registrations#payments', via: :get, :as => :user_payments
    # match 'user/settings/security'     => 'users/registrations#security', via: :get, :as => :user_security
    # match 'user/dashboard'    => 'users/registrations#dashboard', via: :get, :as => :user_dashboard
    # match 'user/account'      => 'users/registrations#account', via: :get, :as => :user_account
  end



  ## Seller Routes -> Admin + Show views
  resource :seller, path: "seller", except: [:index, :show, :new, :create] do
    member do
      get 'home',                         action: :home, as: :home
      get 'activities',                   action: :activities, as: :activities
      get 'announcements',                action: :announcements, as: :announcements

      # Settings routes
      get 'settings',                     action: :settings, as: :settings
      get 'settings/general',             action: :general, as: :settings_general
      get 'settings/account',             action: :account, as: :settings_account
      get 'settings/billing',             action: :billing, as: :settings_billing

      # Product
      resources :product_barcodes, path: "/products/barcode", only: [:new, :create]
      resources :products, path: "/products", except: [:show, :destroy, :edit, :update] do
        resource :product_like, module: :products, as: :like
      end

      resources :seller_products, path: "products/inventory", except: [:new], module: :sellers
      resources :seller_accounts, path: "account", module: :sellers
      resources :seller_locations, path: "settings/locations", module: :sellers

      # Payment routes
      resource :seller_card, path: "settings/billing/card", module: :sellers
      resource :seller_pricing, path: "settings/account/pricing", as: :seller_pricing, controller: :seller_pricing, module: :sellers
      resource :seller_subscription, path: "settings/account/plan", as: :seller_subscription, module: :sellers do
        patch :resume
      end
      resources :seller_payments, path: "settings/account/plan/payment", as: :seller_payments
      resources :seller_charges, path: "settings/billing/charges", as: :seller_charges
    end
  end

  resources :sellers, path: "seller", only: [:new, :create] do
    post :private
    post :public
  end
  get 'seller/:id', to: "sellers#show", as: :show_seller



  ## Categories
  resources :categories, path: "categories", only: [:show, :index]
  get 'product/:id', to: "products#show", as: :show_product
  
  namespace :charts do 
    get 'avg-price'
  end


  # Search
  mount Searchjoy::Engine, at: "searchjoy"
  resource :search, path: "/search", only: [:show]



  # Site primary pages -> Home, About, Terms, Privacy
  get '/partner',           to: "pages#partner"
  get '/terms',             to: "pages#terms"
  get '/privacy',           to: "pages#privacy"
  get '/404',               to: "pages#not_found"



  # Contacts
  resources :contacts, only: [:new, :create, :index], path: "contacts"



  # Root Path
  # root to: "pages#root"
  root to: "pages#home"

  # match "*path" => redirect("/"), via: [:get, :post] # if 404 -> go to homepage

end # end of routes
