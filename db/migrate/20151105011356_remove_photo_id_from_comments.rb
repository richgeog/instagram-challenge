class RemovePhotoIdFromComments < ActiveRecord::Migration
  def change
    remove_reference :comments, :photo, index: true, foreign_key: true
  end
end
