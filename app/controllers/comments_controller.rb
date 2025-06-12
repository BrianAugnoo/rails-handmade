class CommentsController < ApplicationController
  def index
  end
  before_action :authenticate_user!
  before_action :set_car, except: [:destroy]
  before_action :set_comment, only: [:edit, :update]
  before_action :authorize_user!, only: [:edit, :update]

  def new
    @comment = @art.comments.build
  end

  def create
    @comment = @art.comments.build(review_params)
    @comment.user = current_user

    if @comment.save
      redirect_to art_path(@art), notice: "Comment added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @comment.update(review_params)
      redirect_to art_path(@art), notice: "Comment updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @art = @comment.art
      @comment.destroy
      redirect_to art_path(@art), notice: "Comment deleted successfully.", status: :see_other
    end
  end

  private

  def set_art
    @art = Art.find(params[:car_id])
  end

  def set_comment
    @comment = @art.comments.find(params[:id])
  end

  def authorize_user!
    unless @comment.user == current_user
      redirect_to art_path(@art), alert: "You cannot add a comment for your own art."
    end
  end

  def comment_params
    params.require(:comment).permit(:rating, :comment)
  end
end
