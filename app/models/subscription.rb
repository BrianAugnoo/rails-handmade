class Subscription < ApplicationRecord
  belongs_to :subscriber
  belongs_to :subscribed
end
