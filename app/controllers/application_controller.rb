require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception

  before_action :gon_user, unless: :devise_controller?

  private

  def render_error(status, error, message)
    render json: { error: error, error_message: message }, status: status
  end

  def gon_user
    gon.user_id = current_user.id if current_user
  end
end
