class CommentsController < ApplicationController

  def new
    @photo = Photo.find(params[:photo_id])
    @comment = Comment.new
  end

  def create
    @photo = Photo.find(params[:photo_id])
    @photo.comments.create(comment_params)
    redirect_to photos_path
  end

  # def destory
  #   @comment = Comment.find(params[:id])
  #   @comment.destroy
  #   if current_user.id != @comment.user_id
  #     flash[:notice] = 'Comment deleted successfully'
  #     redirect_to photos_path
  #   end
  # end

  def comment_params
    params[:comment][:user_id] = current_user.id
    params.require(:comment).permit(:thoughts, :user_id)
  end
end
