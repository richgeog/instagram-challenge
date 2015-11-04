class AddPhotoIdToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :photo_id, :integer
  end
end
