class ProfileController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end

  def feed
    @arts = User.find(params[:user_id]).arts
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(set_params)
      flash[:notice] = "Profile updated successfully."
      redirect_to profile_path(current_user)
    else
      flash[:alert] = "Failed to update profile."
      render :edit
    end
  end

  def settings
    @user = current_user
  end

  private
  def set_params
    params.require(:user).permit(:user_name, :phone_number, :avatar)
  end
end
