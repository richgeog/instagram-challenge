class PhotosController < ApplicationController

  before_action :authenticate_user!, :expcet => [:index, :show]

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
    if current_user.id != @photo.user_id
      flash[:notice] = 'You are unable to edit this photo'
      redirect_to photos_path
    end
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
