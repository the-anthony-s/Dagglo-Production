Rails.application.routes.draw do
  # Internationalization support
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do


    # Site primary pages -> Home, About, Terms, Privacy
    get '/home', to: "pages#home"


    # Root Path
    root to: "pages#home"

    
  end # end of scope

end # end of routes
