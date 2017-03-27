require "application_responder"

class ApplicationController < ActionController::Base
  include Pundit

  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  after_action :verify_authorized, except: :index, unless: :devise_controller?

  before_action :gon_user, unless: :devise_controller?

  private

  def render_error(status, error, message)
    render json: { error: error, error_message: message }, status: status
  end

  def gon_user
    gon.user_id = current_user.id if current_user
  end

  def user_not_authorized
    respond_to do |format|
      format.html {
        flash[:alert] = 'You are not authorized to perform this action.'
        redirect_to(request.referrer || root_path)
      }
      format.json {
        render json: { error: 'You are not authorized to perform this action.' }, status: :unauthorized
      }
    end
  end
end
