class Conversation < ApplicationRecord
  # reminder convesation.recipient/sender returns the user
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  has_many :messages, dependent: :destroy

  # prevents similar user combinations from entering the database
  validates :recipient, uniqueness: { scope: :sender, message: "You already have a conversation with this user" }

  before_validation :unique_combination

  # track existing conversations between two users
  def self.between?(user1, user2)
    conversation = Conversation.where(recipient: user1, sender: user2).or(Conversation.where(recipient: user2, sender: user1))
    conversation.empty? ? false : true
  end

  # retrieves the conversation between two users
  def self.between(user1, user2)
    conversation = Conversation.where(recipient: user1, sender: user2).or(Conversation.where(recipient: user2, sender: user1))
    conversation.present? ? conversation.first : nil
  end

  def ordered_messages
    self.messages.order(created_at: :asc)
  end

  private
  # Ensures that the sender and recipient IDs are always stored in a consistent order
  def unique_combination
    self.sender_id, self.recipient_id = [ self.sender_id, self.recipient_id ].sort
  end
end
