class SessionController < ApplicationController
  def online
    current_user.make_online!
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append("conversation-#{current_user.id}", partial: "session/online_icon", locals: { user: current_user })
      end
    end
  end

  def offline
    current_user.make_offline!
  end
end
