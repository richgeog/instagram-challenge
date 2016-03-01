class PhotosController < ApplicationController
  before_action :authenticate_user!, expcet: [:index, :show]

  def index
    @photos = Photo.all
  end

  def new
    @user = user
    @photo = Photo.new
  end

  def show
    @photo = photo
  end

  def create
    @user = user
    new_photo_created
  end

  def edit
    @photo = photo
    match_current_user_to_photo
  end

  def update
    @photo = photo
    @photo.update(photo_params)
    redirect_to photos_path
  end

  def destroy
    @photo = photo
    @photo.destroy
    delete_photo_flash_message
    redirect_to photos_path
  end

  private

  def photo_params
    params[:photo][:user_id] = current_user.id
    params.require(:photo).permit(:title, :image, :user_id)
  end

  def user
    @_user ||= User.find(current_user.id)
  end

  def photo
    @_photo ||= Photo.find(params[:id])
  end

  def new_photo_created
    @photo = Photo.create(photo_params)
    if @photo.save
      redirect_to photos_path
    else
      render 'new'
    end
  end

  def match_current_user_to_photo
    return if current_user.id == @photo.user_id
    flash[:notice] = 'You are unable to edit this photo'
    redirect_to photos_path
  end

  def delete_photo_flash_message
    flash[:notice] = 'Photo deleted successfully'
  end
end
