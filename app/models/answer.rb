class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  validates :body, :question_id, :user_id, presence: true

  scope :ordered, -> { order('best DESC, created_at') }

  def mark_best
    transaction do
      Answer.where(question_id: question_id).update_all(best: false)
      update!(best: true)
    end
  end

end
