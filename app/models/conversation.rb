class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :chat, dependent: :destroy
  has_many :messages, dependent: :destroy
  # after_create :create_conversation_for_recipient

  validates :user, presence: true, uniqueness: { scope: :chat_id, message: "You already have a conversation with this user in this chat." }

  # private
  # def create_conversation_for_recipient
  #   sender = self.chat.user
  #   recipient = self.user
  #   if recipient.conversations.where(user_id: sender.id).empty?
  #     puts "Creating conversation for recipient sender: #{sender.id}, recipient: #{recipient.id}"
  #     Conversation.create!(user: self.chat.user, chat: self.user.chat)
  #   end
  # end
end
