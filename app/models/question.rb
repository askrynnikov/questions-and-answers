class Question < ApplicationRecord
  include Attachable
  include Votable
  include Commentable
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, :body, :user_id, presence: true
end
