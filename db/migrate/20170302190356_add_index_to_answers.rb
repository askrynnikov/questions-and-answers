class AddIndexToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_index :answers, [:question_id, :best], name: 'unique_index_to_avoid_duplicate_best_answers',
              where: "best = true", unique: true
  end
end
