class Subscription < ApplicationRecord
  belongs_to :subscriber, class_name: "User", foreign_key: "subscriber_id"
  belongs_to :subscribed, class_name: "User", foreign_key: "subscribed_id"

  validates :subscribed, uniqueness: { scope: :subscriber, message: "You are already subscribed to this user" }
  validate :prevent_self_subscription

  private
  def prevent_self_subscription
    if self.subscriber == self.subscribed
      errors.add(:base, "You cannot subscribe to yourself")
    end
  end
end
