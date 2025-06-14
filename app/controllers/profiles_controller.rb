class ProfilesController < ApplicationController
  def show
    @user = current_user
    @artworks = @user.arts
  end
end
