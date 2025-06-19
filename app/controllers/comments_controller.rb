class CommentsController < ApplicationController
  def index
    @art = Art.find(params[:art_id])
    @comments = @art.comments
  end

  def create
    comment = Comment.new(review: params.dig(:comment, :review))
    art = Art.find(params[:art_id])
    comment.art = art
    comment.user = current_user
    if comment.save
      true
    else
      raise
    end
  end
end
