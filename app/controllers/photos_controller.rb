class PhotosController < ApplicationController

  def index
    @photos = Photo.all
  end

  def new
    @user = User.find(current_user.id)
    @photo = Photo.new
  end

  def create
    @user = User.find(current_user.id)
    @photo = Photo.create(photo_params)
    if @photo.save
      redirect_to photos_path
    else
      render 'new'
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.update(photo_params)
    redirect_to '/photos'
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = 'Photo deleted successfully'
    redirect_to '/photos'
  end

  def photo_params
    params[:photo][:user_id] = current_user.id
    params.require(:photo).permit(:title, :image, :user_id)
  end
end
