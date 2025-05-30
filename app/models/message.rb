class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  # always use this method to create a message in controller
  def self.create_in_conversation(params)
    recipient = params[:recipient]
    user = params[:user]
    content = params[:content]
     if Conversation.between?(recipient, user)
       conversation = Conversation.between(recipient, user)
       Message.create!(content: content, conversation: conversation, user: user)
     else
       conversation = Conversation.create!(recipient: recipient, sender: user)
       Message.create!(content: content, conversation: conversation, user: user)
     end
  end
end
