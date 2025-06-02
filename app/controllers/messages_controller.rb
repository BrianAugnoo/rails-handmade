class MessagesController < ApplicationController
  before_action :set_params, only: [ :create ]
  def create
    @message = Message.new(set_params)
    recipient = User.find(params[:user_id])
    @message.recipient = recipient
    if @message.save_in_conversation(recipient: recipient, user: current_user)
      create_notification(user: current_user, content: @message.content, recipient: recipient)
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

  def create_notification(notification_params)
    notification_params[:content] = "#{notification_params[:recipient].user_name} sent you a message: #{notification_params[:content]}"
    notification = Notification.new(content: notification_params[:content])
    notification.message_notification(notification_params)
  end
end
