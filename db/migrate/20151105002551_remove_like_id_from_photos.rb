class RemoveLikeIdFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :like, :has_many
  end
end
