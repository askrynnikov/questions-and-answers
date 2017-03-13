class AddIndexToVotes < ActiveRecord::Migration[5.0]
  def change
    remove_index :votes, [:votable_id, :votable_type]

    add_index :votes, [:user_id, :votable_id, :votable_type], unique: true
  end
end
