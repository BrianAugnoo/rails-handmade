class ConversationsController < ApplicationController
  before_action :find_conversation, only: [ :show ]

  def index
    @conversations = current_user.conversations

    if params[:query].present?
      @conversations = @conversations.select do |conversation|
        conversation.interlocutor(current_user).user_name.downcase.include?(params[:query].downcase)
      end
    end
  end

  def show
    @messages = @conversation.ordered_messages
    @message = Message.new
    @interlocutor = @conversation.interlocutor(current_user)
  end

  private
  def find_conversation
    @conversation = Conversation.find(params[:id])
  end
end
