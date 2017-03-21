class Authorization < ApplicationRecord
  include HasUser

  validates :provider, :uid, presence: true
end
