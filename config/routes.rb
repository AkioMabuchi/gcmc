Rails.application.routes.draw do
  root "home#top"

  get "/terms", to: "home#terms"
  get "/privacy", to: "home#privacy"
  get "/contact", to: "home#contact_form"
  post "/contact", to: "home#contact"
  get "/contact/done", to: "home#contact_done"
  get "/about", to: "home#about"



  get "/login", to: "users#login_form"
  get "/login/forgot-password", to: "users#forgot_password_form"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout"

  get "/signup", to: "users#signup_form"
  post "/signup", to: "users#signup"
  post "/signup/confirm/permalink", to: "users#confirm_exists_permalink"
  post "/signup/confirm/email", to: "users#confirm_exists_email"
  get "/signup/notice", to: "users#signup_notice"
  get "/signup/confirmation", to: "users#signup_confirmation"
  post "/signup/confirmation", to: "users#signup_confirm"
  get "/signup/done", to: "users#signup_done"

  get "/auth/twitter/callback", to: "users#twitter_callback"
  get "/auth/github/callback", to: "users#github_callback"
  post "/auth/twitter/callback/done", to: "users#twitter_post"
  post "/auth/github/callback/done", to: "users#github_post"
  get "/auth/failure", to: "users#auth_failure"

  get "/search", to: "home#search"

  get "/users", to: "users#index"
  get "/users/user/:permalink", to: "users#show"
  get "/users/invitations", to: "users#invitations"
  get "/users/settings/profile", to: "users#profile_form"
  get "/users/settings/profile/done", to: "users#profile_done"
  get "/users/settings/sns", to: "users#sns_form"
  get "/users/settings/sns/done", to: "users#sns_done"

  get "/new", to: "projects#create_form"
  post "/new", to: "projects#create"

  get "/projects", to: "projects#index"
  get "/projects/:permalink", to: "projects#show"
  get "/projects/:permalink/settings", to: "projects#settings"

  get "/articles", to: "articles#index"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
