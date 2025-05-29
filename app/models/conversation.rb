class Conversation < ApplicationRecord
  # reminder convesation.recipient/sender returns the user
  belongs_to :recipient
  belongs_to :sender
end
