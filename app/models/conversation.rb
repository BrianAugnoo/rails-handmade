class Conversation < ApplicationRecord
  # reminder convesation.recipient/sender returns the user
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  has_many :messages, dependent: :destroy
end
