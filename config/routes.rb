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
  devise_for :users, path: 'user', path_names: {sing_in: "sign_in", sing_out: "sign_out", sing_up: "sign_up", edit: "edit"}, :controllers => {
    :registrations            => "users/registrations",
    :confirmations            => "users/confirmations",
    :invitations              => "users/invitations",
    # :omniauth_callbacks       => "sellers/omniauth_callbacks",
    :passwords                => "users/passwords",
    :sessions                 => "users/sessions",
    :unlocks                  => "users/unlocks"
  }
  # devise_scope :user do
  #   match 'user/settings/profile'      => 'users/registrations#edit', via: :get, :as => :user_profile # default Devise edit page
  #   # match 'user/settings/payments'     => 'users/registrations#payments', via: :get, :as => :user_payments
  #   # match 'user/settings/security'     => 'users/registrations#security', via: :get, :as => :user_security
  #   # match 'user/dashboard'    => 'users/registrations#dashboard', via: :get, :as => :user_dashboard
  #   # match 'user/account'      => 'users/registrations#account', via: :get, :as => :user_account
  # end



  ## Seller Routes -> Admin + Show views
  resource :seller, path: "seller", except: [:index, :show, :new, :create] do
    member do
      get 'help',                         action: :help, as: :help
      get 'dashboard',                    action: :dashboard, as: :dashboard
      get 'products',                     action: :products, as: :products
      get 'locations',                    action: :locations, as: :locations
      # get 'users',                        action: :users, as: :users
      get 'activities',                   action: :activities, as: :activities
      get 'announcements',                action: :announcements, as: :announcements

      # Settings routes
      get 'settings',                     action: :settings, as: :settings
      get 'settings/general',             action: :general, as: :settings_general
      get 'settings/account',             action: :account, as: :settings_account
      get 'settings/billing',             action: :billing, as: :settings_billing
      # get 'settings/shipping',            action: :shipping, as: :settings_shipping
      # get 'settings/faq',                 action: :payments, as: :settings_faq

      resources :seller_products, path: "products/inventory", as: :inventories, only: [:show, :edit, :update, :destroy], module: :sellers
      resources :seller_accounts, path: "account", as: :accounts, only: [:show, :edit, :update, :new, :create, :destroy], module: :sellers
      resources :seller_locations, path: "locations", as: :locations, only: [:show, :new, :create, :update, :destroy, :edit], module: :sellers

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



  ## Carriers
  resources :carriers, path: "carrier", only: [:new, :create]



  ## Product Routes
  resources :products, path: "seller/products", except: [:show, :destroy, :edit, :update]
  get 'product/:id', to: "products#show", as: :show_product


  ## Categories
  resources :categories, path: "categories", only: [:show, :index]


  # Search
  mount Searchjoy::Engine, at: "searchjoy"

  # resource :search, path: "search", only: [:show]
  get '/search', to: 'searches#show'



  # Site primary pages -> Home, About, Terms, Privacy
  get '/home',          to: "pages#home"
  get '/promo',         to: "pages#promo"
  get '/sell',          to: "pages#sell"
  get '/terms',         to: "pages#terms"
  get '/privacy',       to: "pages#privacy"



  # Contacts
  resources :contacts, only: [:new, :create], path: "contacts"



  # Root Path
  root to: "pages#promo"
  # root to: "pages#home"

  match "*path" => redirect("/"), via: [:get, :post] # if 404 -> go to homepage

end # end of routes
