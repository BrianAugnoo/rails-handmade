class ProfileController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end

  def feed
    @arts = User.find(params[:user_id]).arts
  end
end
