class Subscription < ApplicationRecord
  belongs_to :user
  has_many :subscribers, dependent: :destroy
end
