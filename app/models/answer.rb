class Answer < ApplicationRecord
  belongs_to :question, foreign_key: 'question_id'

  validates :body, presence: true;
end
