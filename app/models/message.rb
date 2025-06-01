class Message < ApplicationRecord
  attr_accessor :current_user
  belongs_to :conversation
  belongs_to :user
  after_create_commit :broadcast_create

  # always use this method to create a message in controller
  def save_in_conversation(params)
    recipient = params[:recipient]
    user = params[:user]
    self.user = user
    self.content = params[:content] if params[:content].present?
      if Conversation.between?(recipient, user)
        conversation = Conversation.between(recipient, user)
        self.conversation = conversation
      else
        conversation = Conversation.create!(recipient: recipient, sender: user)
        self.conversation = conversation
      end
    self.save ? true : false
  end

  private
  def broadcast_create
    broadcast_append_to "conversation_#{self.conversation.id}",
                         target: "messages",
                         partial: "conversations/message",
                         locals: { message: self, position: (self.user == self.current_user ? "ms-auto" : "") }
  end
end
