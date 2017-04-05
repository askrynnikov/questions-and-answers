class Question < ApplicationRecord
  include Attachable
  include Votable
  include Commentable
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :title, :body, :user_id, presence: true

  scope :lastday, -> { where(created_at: 1.day.ago..Time.now) }
end
