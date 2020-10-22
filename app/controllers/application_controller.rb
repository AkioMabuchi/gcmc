class ApplicationController < ActionController::Base
  class Forbidden < ActionController::ActionControllerError; end

  before_action :set_current_user

  rescue_from Forbidden, with: :render_403
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from Exception, with: :render_500

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      session[:user_id] = nil
    end
  end

  def authenticate_user
    unless @current_user
      flash[:notice] = "ログインが必要です"
      redirect_to("/")
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/")
    end
  end

  def render_403
    render file: Rails.root.join("public/403.html"), status: 403, layout: false, content_type: 'text/html'
  end

  def render_404
    render file: Rails.root.join("public/404.html"), status: 404, layout: false, content_type: 'text/html'
  end

  def render_500

  end
end
