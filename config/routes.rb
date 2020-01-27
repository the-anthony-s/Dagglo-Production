Rails.application.routes.draw do

  mount StripeEvent::Engine, at: "/webhooks/stripe"
  
  # Internationalization support
  # scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  #   -> all routes here <-
  # end


  ## Users Controller -> Devise
  devise_for :users, path: 'user', path_names: {sing_in: "sign_in", sing_out: "sign_out", sing_up: "sign_up", edit: "edit"}, :controllers => {
    :registrations            => "users/registrations",
    :confirmations            => "users/confirmations",
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
      get 'dashboard',                    action: :dashboard, as: :dashboard
      get 'products',                     action: :products, as: :products
      get 'locations',                    action: :locations, as: :locations
      get 'activities',                   action: :activities, as: :activities
      
      # Settings routes
      get 'settings',                     action: :settings, as: :settings
      get 'settings/general',             action: :general, as: :settings_general
      get 'settings/account',             action: :account, as: :settings_account
      get 'settings/billing',             action: :billing, as: :settings_billing
      # get 'settings/shipping',            action: :shipping, as: :settings_shipping
      # get 'settings/faq',                 action: :payments, as: :settings_faq

      resources :seller_products, path: "products/inventory", as: :inventories, only: [:show, :edit, :update, :destroy]
      resources :seller_accounts, path: "account", as: :accounts, only: [:show]
      resources :seller_locations, path: "locations", as: :locations, only: [:show, :new, :create, :update, :destroy, :edit]
      
      # Payment routes
      resource :seller_card, path: "settings/billing/card"
      resource :seller_pricing, path: "settings/account/pricing", as: :seller_pricing, controller: :seller_pricing
      resource :seller_subscription, path: "settings/account/plan", as: :seller_subscription do
        patch :resume
      end
      resources :seller_payments, path: "settings/account/plan/payment", as: :seller_payments
      resources :seller_charges, path: "settings/billing/charges", as: :seller_charges
    end
  end
  
  resources :sellers, path: "seller", only: [:new, :create]
  get 'seller/:id', to: "sellers#show", as: :show_seller



  ## Product Routes
  resources :products, path: "seller/products", except: [:show, :destroy, :update, :edit]
  get 'product/:id', to: "products#show", as: :show_product
  


  # Site primary pages -> Home, About, Terms, Privacy
  get '/home', to: "pages#home"



  # Root Path
  root to: "pages#home"


end # end of routes
