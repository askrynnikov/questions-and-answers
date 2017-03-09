class Question < ApplicationRecord
  include HasUser
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  validates :title, :body, :user_id, presence: true

  accepts_nested_attributes_for :attachments, reject_if: proc { |attrib| attrib['file'].nil? }
end
