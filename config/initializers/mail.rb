ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_caching = true
ActionMailer::Base.default_options = {
    host: Rails.application.credentials.email[:host]
}

ActionMailer::Base.smtp_settings = {
    address: Rails.application.credentials.email[:address],
    domain: Rails.application.credentials.email[:domain],
    port: 587,
    authentication: :login,
    user_name: Rails.application.credentials.email[:access_key_id],
    password: Rails.application.credentials.email[:secret_access_key]
}