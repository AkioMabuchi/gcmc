Rails.application.routes.draw do
  mount ActionCable.server, at: "/cable"
  root "home#top"

  get "/terms", to: "home#terms"
  get "/privacy", to: "home#privacy"
  get "/contact", to: "home#contact_form"
  post "/contact", to: "home#contact"
  get "/contact/done", to: "home#contact_done"
  get "/about", to: "home#about"

  get "/login", to: "users#login_form"

  post "/login", to: "users#login"
  get "/login/forgot", to: "users#password_forgot_form"
  post "/login/forgot", to: "users#password_forgot"
  get "/login/forgot/done", to: "users#password_forgot_done"

  get "/reset", to: "users#password_reset_form"
  post "/reset", to: "users#password_reset"
  post "/logout", to: "users#logout"

  get "/signup", to: "users#signup_form"
  post "/signup", to: "users#signup"
  get "/signup/details", to: "users#signup_details_form"
  post "/signup/details", to: "users#signup_details"

  get "/signup/notice", to: "users#signup_notice"
  get "/signup/confirmation", to: "users#signup_confirmation"
  post "/signup/confirmation", to: "users#signup_confirm"
  get "/signup/done", to: "users#signup_done"

  get "/auth/twitter/callback", to: "users#twitter_callback"
  get "/auth/github/callback", to: "users#github_callback"
  post "/auth/twitter/callback/done", to: "users#twitter_post"
  post "/auth/github/callback/done", to: "users#github_post"
  get "/auth/failure", to: "users#auth_failure"

  get "/verification", to: "users#verification"
  get "/verify", to: "users#verify_form"
  post "/verify", to: "users#verify"

  get "/search", to: "home#search"

  get "/users", to: "users#index"
  get "/users/:permalink", to: "users#show"
  get "/users/:permalink/invite", to: "users#invite_form"
  post "/users/:permalink/invite", to: "users#invite"

  get "/settings", to: "users#profile_setting_form"
  post "/settings", to: "users#profile_setting_update"
  get "/settings/skills", to: "users#skills_setting_form"
  post "/settings/skills", to: "users#skills_setting_update"
  get "/settings/portfolios", to: "users#portfolios_setting_form"
  post "/settings/portfolios", to: "users#portfolios_setting_update"
  get "/settings/invitations", to: "users#invitations_setting_form"
  post "/settings/invitations", to: "users#invitations_setting_update"
  get "/settings/email", to: "users#email_setting_form"
  post "/settings/email", to: "users#email_setting_update"
  post "/settings/email/create", to: "users#email_setting_create"
  get "/settings/password", to: "users#password_setting_form"
  post "/settings/password", to: "users#password_setting_update"
  get "/settings/sns", to: "users#sns_setting_form"
  post "/settings/sns", to: "users#sns_setting_update"
  post "/settings/sns/disconnect/twitter", to: "users#disconnect_twitter"
  post "/settings/sns/disconnect/github", to: "users#disconnect_github"
  get "/settings/destroy", to: "users#destroy_form"
  post "/settings/destroy", to: "users#destroy"

  get "/invitations", to: "users#invitations"
  post "/invitations", to: "users#invitations_answer"

  get "/new", to: "projects#create_form"
  post "/new", to: "projects#create"

  get "/projects", to: "projects#index"
  get "/projects/:permalink", to: "projects#show"
  get "/projects/:permalink/settings", to: "projects#basic_setting_form"
  post "/projects/:permalink/settings", to: "projects#basic_setting_update"
  get "/projects/:permalink/settings/tags", to: "projects#tags_setting_form"
  post "/projects/:permalink/settings/tags", to: "projects#tags_setting_update"
  get "/projects/:permalink/settings/links", to: "projects#links_setting_form"
  post "/projects/:permalink/settings/links", to: "projects#links_setting_update"
  get "/projects/:permalink/settings/environment", to: "projects#environment_setting_form"
  post "/projects/:permalink/settings/environment", to: "projects#environment_setting_update"
  get "/projects/:permalink/settings/wants", to: "projects#wants_setting_form"
  post "/projects/:permalink/settings/wants", to: "projects#wants_setting_update"
  get "/projects/:permalink/settings/publish", to: "projects#publish_setting_form"
  post "/projects/:permalink/settings/publish", to: "projects#publish_setting_update"
  get "/projects/:permalink/settings/destroy", to: "projects#destroy_form"
  post "/projects/:permalink/settings/destroy", to: "projects#destroy"

  get "/projects/:permalink/join", to: "projects#join_form"
  post "/projects/:permalink/join", to: "projects#join"
  get "/projects/:permalink/requests", to: "projects#join_requests_form"
  post "/projects/:permalink/requests", to: "projects#join_requests_answer"

  get "/articles", to: "articles#index"

  get "/messages", to: "messages#index"
  get "/messages/:permalink", to: "messages#show"
  post "/messages/:permalink/create", to: "messages#create"

  post "/sampleprojects", to: "projects#sample_projects"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
