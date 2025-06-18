class LikesController < ApplicationController
  def create
    like = Like.new(art_id: params[:art_id], user_id: current_user.id)
    art = Art.find(params[:art_id])
    if like.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("art_#{art.id}_likes", partial: "home/like", locals: { current_user: current_user, art: art })
        end
      end
    else
      raise
    end
  end

  def destroy
    art = Art.find(params[:art_id])
    if Like.find_by(art: art, user: current_user).destroy
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("art_#{art.id}_likes", partial: "home/like", locals: { current_user: current_user, art: art })
        end
      end
    else
      raise
    end
  end
end
