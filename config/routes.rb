Rails.application.routes.draw do

  # Site primary pages -> Home, About, Terms, Privacy
  get '/home', to: "pages#home"


  # Root Path
  root to: "pages#home"

end
