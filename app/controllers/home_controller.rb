class HomeController < ApplicationController
  protect_from_forgery except: :contact
  def top

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
    redirect_to("/contact/done")
  end

  def contact_done

  end

  def about
  end

  def search

  end
end
