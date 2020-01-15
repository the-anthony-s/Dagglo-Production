Rails.application.routes.draw do

  # Site primary pages -> Home, About, Terms, Privacy
  get "pages/*page" => "pages#show", path: "/"


  # Root Path
  root to: "pages#home"

end
