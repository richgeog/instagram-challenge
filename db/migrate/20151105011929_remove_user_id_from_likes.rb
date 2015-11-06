class RemoveUserIdFromLikes < ActiveRecord::Migration
  def change
    remove_column :likes, :user_id, :integer
  end
end
