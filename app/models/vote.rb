class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :rating, inclusion: {in: [-1, 1], message: "%{value} is not included in the set"}
end