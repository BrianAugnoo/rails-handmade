class Notification < ApplicationRecord
  belongs_to :user

  def message_notification(params)
    self.user = params[:user]
    if self.save
      broadcast_notification(params[:recipient]) ? true : false
    else
      false
    end
  end

  private

  def broadcast_notification(recipient)
    broadcast_append_to "notification_#{recipient.id}",
                         target: "notifications",
                         partial: "notifications/notification",
                         locals: { notification: self }
    true
  end
end
