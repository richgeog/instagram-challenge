class RemoveUserIdFromPhotos < ActiveRecord::Migration
  def change
    remove_reference :photos, :user, index: true, foreign_key: true
  end
end
