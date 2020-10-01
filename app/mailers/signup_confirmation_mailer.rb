class SignupConfirmationMailer < ApplicationMailer
  def send_text(name, email, hash, number_1, number_2, number_3, number_4, number_5)
    @name = name
    @hash = hash
    @number_1 = number_1
    @number_2 = number_2
    @number_3 = number_3
    @number_4 = number_4
    @number_5 = number_5
    @address = Rails.env.development? ? "http://localhost:3000" : "https://gcmatchingcenter.com"

    mail(subject: "『GCMC』アカウント認証のお願い", to: email) do |format|
      format.text
    end
  end
end
