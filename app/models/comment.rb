class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :content, presence: true, length: { minimum: 10, maximum: 1000 }
end
