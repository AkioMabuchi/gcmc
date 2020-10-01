class ContactMailer < ApplicationMailer
  def send_text(email, title, message)
    @email = email
    @title = title
    @message = message
    mail(subject: "『GCMC』よりお問い合わせ", to: Rails.application.credentials.email[:admin]) do |format|
      format.text
    end
  end
end
