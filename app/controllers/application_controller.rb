class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_navbar_data

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :user_name ])
  end


  def set_navbar_data
    return unless user_signed_in?

    @current_user = current_user
    @artwork_count = current_user.arts.count
    @subscriber_count = current_user.subscribers.count # Adjust based on your model
  end
end
