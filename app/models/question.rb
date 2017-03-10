class Question < ApplicationRecord
  include HasUser
  include Attachable
  include Votable
  has_many :answers, dependent: :destroy

  validates :title, :body, :user_id, presence: true
end
