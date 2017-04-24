class Answer < ApplicationRecord
  include Attachable
  include Votable
  include Commentable
  belongs_to :question, touch: true
  belongs_to :user

  validates :body, :question_id, :user_id, presence: true

  scope :ordered, -> { order('best DESC, created_at') }

  after_create :notify

  def mark_best
    transaction do
      Answer.where(question_id: question_id).update_all(best: false)
      update!(best: true)
    end
  end

  private

  def notify
    SubscriptionQuestionJob.perform_later(self)
  end
end
