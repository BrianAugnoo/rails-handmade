class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :art

  validates :review, presence: true
  before_save :sanitize_review

  private

  def sanitize_review
    self.review = Obscenity.sanitize(self.review)
  end
end
