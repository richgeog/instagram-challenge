class Photo < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user

  has_attached_file :image, styles: { medium: "300x300>",
                                      thumb: "200x200>" },
                            default_url: "/images/:style/test.jpg"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :title, length: { minimum: 3 }

  def create_like(user)
    @like = likes.build
    @like.user_id = user.id
    @like.save
  end
end
