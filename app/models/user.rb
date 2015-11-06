class User < ActiveRecord::Base

  has_many :photos
  has_many :likes
  has_many :comments
  has_many :liked_photos, through: :likes, source: :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
