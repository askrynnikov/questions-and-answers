class Api::V1::ProfilesController < ApplicationController
  skip_after_action :verify_authorized

  def me
    respond_with current_resource_owner
  end

  def index
    respond_with User.without_user(current_resource_owner)
  end
end
