class User < ActiveRecord::Base

  has_many :photos
  has_many :likes
  has_many :comments
  has_many :liked_photos, through: :likes, source: :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def has_liked? post
    likes.where(photo_id: photo.id).present?
  end

end
