class MessagesController < ApplicationController
  before_action :set_params, only: [ :create ]
  def create
    @message = Message.new(set_params)
    recipient = User.find(params[:user_id])
    if @message.save_in_conversation(recipient: recipient, user: current_user)
      respond_to do |format|
        format.turbo_stream do
          position = @message.user == current_user ? "ms-auto" : ""
          render turbo_stream: turbo_stream.append("messages", partial: "conversations/message", locals: { message: Message.last, position: position })
        end
        format.html { redirect_to conversation_path(@message.conversation) }
      end
    else
      redirect_to conversation_path(Conversation.between(current_user, recipient)), alert: "Message could not be sent."
    end
  end

  private
  def set_params
    params.require(:message).permit(:content)
  end
end
