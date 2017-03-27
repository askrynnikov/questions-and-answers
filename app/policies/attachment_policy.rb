class AttachmentPolicy < ApplicationPolicy
  def destroy?
    user && user.id == record.attachable.user_id
  end
end