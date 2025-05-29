class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :subscriber, classname: "User", foreign_key: "subscriber_id"
end
