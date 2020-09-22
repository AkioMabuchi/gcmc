class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.email[:address]
  layout 'mailer'
end
