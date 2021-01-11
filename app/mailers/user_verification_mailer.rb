class UserVerificationMailer < ApplicationMailer
  def send_text(name, email, hash_code)
    @name = name
    @hash = hash_code

    if Rails.env.production? or Rails.env.staging?
      @address = "https://gcmatchingcenter.com"
    else
      @address = "http://localhost:3000"
    end

    mail subject: "『GCMC』アカウント認証のお願い", to: email do |format|
      format.text
    end
  end
end
