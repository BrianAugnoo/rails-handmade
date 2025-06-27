class ProfileController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end

  def feed
    @arts = User.find(params[:user_id]).arts.order(created_at: :desc)
    @last = Art.find(params[:data])
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(set_params)
      flash[:notice] = "Profile updated successfully."
      redirect_to profile_path(current_user)
    else
      raise current_user.errors.full_messages.to_sentence
      flash[:alert] = "Failed to update profile."
      render :edit
    end
  end

  def settings
    @user = current_user
  end

  private
  def set_params
    profile_params = params.require(:user).permit(:user_name, :phone_number, :avatar)
    profile_params[:user_name] = current_user.user_name if profile_params[:user_name] === ""
    profile_params
  end
end
