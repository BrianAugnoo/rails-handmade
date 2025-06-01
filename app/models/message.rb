class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

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
end
