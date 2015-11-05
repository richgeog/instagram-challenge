class RemoveUserIdFromComments < ActiveRecord::Migration
  def change
    remove_reference :comments, :user, index: true, foreign_key: true
  end
end
