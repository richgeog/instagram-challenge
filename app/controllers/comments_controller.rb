class CommentsController < ApplicationController
  def new
    @photo = photo
    @comment = Comment.new
  end

  def create
    @photo = photo
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

  private

  def comment_params
    params[:comment][:user_id] = current_user.id
    params.require(:comment).permit(:thoughts, :user_id)
  end

  def photo
    @_photo ||= Photo.find(params[:photo_id])
  end
end
