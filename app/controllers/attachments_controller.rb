class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attachment, only: [:destroy]

  respond_to :js

  def destroy
    @attachment.destroy #if current_user.author_of?(@attachment.attachable)
    respond_with(@attachment)
  end

  def set_attachment
    @attachment = Attachment.find(params[:id])
    authorize @attachment
  end
end
