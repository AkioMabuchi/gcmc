Rails.application.routes.draw do
  root "home#top"

  get "/terms", to: "home#terms"
  get "/privacy", to: "home#privacy"
  get "/contact", to: "home#contact"
  get "/about", to: "home#about"
  get "/projects", to: "projects#index"

  get "/users", to: "users#index"

  get "/board", to: "board#index"

  get "/events", to: "events#index"

  get "/login", to: "users#login_form"
  get "/login/forgot-password", to: "users#forgot_password_form"

  post "/login", to: "users#login"

  get "/signup", to: "users#signup_form"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
