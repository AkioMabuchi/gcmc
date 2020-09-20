Rails.application.routes.draw do
  get 'articles/index'
  root "home#top"

  get "/terms", to: "home#terms"
  get "/privacy", to: "home#privacy"
  get "/contact", to: "home#contact"
  get "/about", to: "home#about"
  get "/projects", to: "projects#index"
  get "/projects/create", to: "projects#create_form"
  get "/projects/attends", to: "projects#attends"
  get "/projects/project/:permalink", to: "projects#show"

  get "/users", to: "users#index"
  get "/users/user/:permalink", to: "users#show"

  get "/board", to: "board#index"

  get "/events", to: "events#index"
  
  get "/articles", to: "articles#index"

  get "/login", to: "users#login_form"
  get "/login/forgot-password", to: "users#forgot_password_form"

  post "/login", to: "users#login"
  post "/logout", to: "users#logout"
  get "/signup", to: "users#signup_form"
  post "/signup", to: "users#signup"
  post "/signup/confirm/permalink", to: "users#confirm_exists_permalink"
  post "/signup/confirm/email", to: "users#confirm_exists_email"
  get "/signup/done", to: "users#signup_done"

  get "/auth/twitter/callback", to: "users#twitter_callback"
  get "/auth/github/callback", to: "users#github_callback"
  post "/auth/twitter/callback/done", to: "users#twitter_post"
  post "/auth/github/callback/done", to: "users#github_post"
  get "/auth/failure", to: "users#auth_failure"

  get "/search", to: "home#search"
  get "/settings/sns", to: "users#sns_form"
  get "/settings/sns/done", to: "users#sns_done"

  get "/settings/projects/:permalink", to: "projects#settings_form"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
