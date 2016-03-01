class User < ActiveRecord::Base
  has_many :photos
  has_many :likes
  has_many :comments
  has_many :liked_photos, through: :photos, source: :likes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def liked?(photo)
    likes.where(photo_id: photo.id).present?
  end
end
