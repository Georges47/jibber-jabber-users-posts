class RemoveCreatorIdFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :creator_id
  end
end
