class ApplicationController < ActionController::Base
  class Forbidden < ActionController::ActionControllerError
  end

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from Forbidden, with: :render_403

  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      session[:user_id] = nil
    end
  end

  private

  def render_403
    render file: Rails.root.join("public/403.html"), status: 403, layout: false, content_type: 'text/html'
  end

  def render_404
    render file: Rails.root.join("public/404.html"), status: 404, layout: false, content_type: 'text/html'
  end

  def render_500

  end
end
