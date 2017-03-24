class Answer < ApplicationRecord
  include Attachable
  include Votable
  include Commentable
  belongs_to :question
  belongs_to :user

  validates :body, :question_id, :user_id, presence: true

  scope :ordered, -> { order('best DESC, created_at') }

  def mark_best
    transaction do
      Answer.where(question_id: question_id).update_all(best: false)
      update!(best: true)
    end
  end

end
