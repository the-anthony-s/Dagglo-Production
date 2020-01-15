Rails.application.routes.draw do

  
  # Internationalization support
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do


    # Users Controller -> Devise
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

    

    # Site primary pages -> Home, About, Terms, Privacy
    get '/home', to: "pages#home"



    # Root Path
    root to: "pages#home"

    
  end # end of scope

end # end of routes
