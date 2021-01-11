class HomeController < ApplicationController
  protect_from_forgery except: [
      :contact
  ]

  def top
    if @current_user
      @owner_projects = Project.where(owner_user_id: @current_user.id)
    else

    end
  end

  def terms
  end

  def privacy
  end

  def contact_form
  end

  def contact
    email = params[:email]
    title = params[:title]
    message = params[:message]

    ContactMailer.send_text(email, title, message).deliver_now

    flash[:done] = "お問い合わせありがとうございます。"
    redirect_to "/contact"
  end

  def about
  end

  def search

  end
end
