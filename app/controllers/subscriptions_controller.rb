class SubscriptionsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    Subscription.create(subscriber: current_user, subscribed: @user)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(
          "user-controll",
          partial: "profile/user_controll",
          local: { current_user: current_user }
        ),
        turbo_stream.update(
          "subscribeds",
          partial: "profile/subscribeds"
        )
      ]
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    subscription = Subscription.find(params[:id])
    subscription.destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(
          "user-controll",
          partial: "profile/user_controll",
          local: { current_user: current_user }
        ),
        turbo_stream.update(
          "subscribeds",
          partial: "profile/subscribeds"
        )
      ]
      end
    end
  end
end
