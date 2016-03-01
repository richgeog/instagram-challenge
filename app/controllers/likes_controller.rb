class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    @photo.create_like(current_user)
    render json: { new_like_count: @photo.likes.count }
  end
end
