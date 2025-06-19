class LikesController < ApplicationController
  def create
    art = Art.find(params[:art_id])
    like = Like.new(art_id: art.id, user_id: current_user.id)
    like.current_user = current_user
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
    like = Like.find_by(art: art, user: current_user)
    like.current_user = current_user
    if like.destroy
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
