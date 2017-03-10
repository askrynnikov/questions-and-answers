module Votable
  extend ActiveSupport::Concern
  included do
    has_many :votes, as: :votable, dependent: :destroy
    accepts_nested_attributes_for :votes #, reject_if: :all_blank, allow_destroy: true
  end

  def rating
    votes.sum(:rating)
  end

  def vote_user(user)
    votes.find_by(user: user)
  end
end