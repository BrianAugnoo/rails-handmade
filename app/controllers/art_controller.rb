class ArtController < ApplicationController
  def new
    @art = Art.new
  end

  def create
    @art = Art.new(set_params)
    @art.user = current_user
    if @art.save
      redirect_to root_path, notice: "Art created successfully."
    else
      flash.now[:alert] = @art.errors.full_messages.to_sentence
      render :new
    end
  end

  private
  def set_params
    params.require(:art).permit(:description, :photo, :video, :tags)
  end
end
