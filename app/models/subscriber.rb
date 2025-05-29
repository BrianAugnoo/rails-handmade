class Subscriber < ApplicationRecord
  belongs_to :user
  belongs_to :subscription
  before_validation :prevent_auto_subscribe

  private
  def prevent_auto_subscribe
    if self.user == self.subscription.user
      errors.add(:base, "You cannot subscribe to your own subscription")
    end
  end
end
