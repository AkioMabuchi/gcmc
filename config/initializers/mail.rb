ActionMailer::Base.smtp_settings = {
    :address => "email-smtp.ap-northeast-1.amazonaws.com",
    :port => 587,
    :domain => "gcmatchingcenter.com",
    :authentication => :login,
    :user_name => Rails.application.credentials.aws[:ses][:access_key_id],
    :password => Rails.application.credentials.aws[:ses][:secret_access_key]
}
