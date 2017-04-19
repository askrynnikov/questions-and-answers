class Question < ApplicationRecord
  include Attachable
  include Votable
  include Commentable
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :title, :body, :user_id, presence: true

  scope :lastday, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
  # scope :lastday, -> { where(created_at: 1.day.ago..Time.now) }

  after_create :subscribe

  private

  def subscribe
    subscriptions.create(user_id: user_id)
  end
end
