class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  has_many :messages

  validates :content, presence: true

  private
  def create_inexisting_conversation
    if self.conversation.nil?
      self.conversation = Conversation.create!(user: self.user, chat: self.chat)
    end
  end
end
