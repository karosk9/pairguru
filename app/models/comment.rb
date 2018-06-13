class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  validates :body, presence: true
  validates :movie, :user, presence: true
  validates :user, uniqueness: { scope: :movie,
                                 message: "user can comment only once on movie" }

  scope :recent, -> {where('comments.created_at > ?', 1.week.ago)}


end
