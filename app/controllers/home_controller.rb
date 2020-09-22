class HomeController < ApplicationController
  def top
    unless @current_user
      @header_top_guest = true
    end
  end

  def terms
  end

  def privacy
  end

  def contact
  end

  def about
  end

  def search

  end
end
