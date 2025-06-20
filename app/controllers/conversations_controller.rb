class ConversationsController < ApplicationController
  before_action :find_conversation, only: [ :show ]

  def index
    @conversations = current_user.conversations
  end

  def show
    @messages = @conversation.ordered_messages
    @message = Message.new
    @interlocutor = @conversation.interlocutor(current_user)
  end

  def new
    @interlocutor = User.find(params[:recipient_id])
    @message = Message.new
  end

  private
  def find_conversation
    @conversation = Conversation.find(params[:id])
  end
end
