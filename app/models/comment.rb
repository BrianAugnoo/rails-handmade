class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :art

  validates :review, presence: true
  before_save :sanitize_review
  after_create_commit :create_broadcast

  private

  def sanitize_review
    self.review = Obscenity.sanitize(self.review)
  end

  def create_broadcast
    broadcast_append_to "turbo_comments_#{self.art.id}",
                         target: "comments_#{self.art.id}",
                         partial: "comments/comment",
                         locals: { comment: self }

    broadcast_update_to "turbo_#{art.id}_comments",
                        target: "art_#{art.id}_comments",
                        partial: "home/comment",
                        locals: { count: self.art.comments.size }
  end
end
