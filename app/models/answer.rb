class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, :question_id, :user_id, presence: true

  scope :ordered, -> { order('best DESC, created_at') }

  def mark_best
    ActiveRecord::Base.transaction do
      question.answers.where(best: true).find_each { |answer| answer.update!(best: false) }
      update!(best: true)
    end
  end
end
