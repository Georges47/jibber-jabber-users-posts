class AddRepliedPostToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :replied_post, foreign_key: { to_table: :posts }, null: true
  end
end
