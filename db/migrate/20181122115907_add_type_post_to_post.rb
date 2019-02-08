class AddTypePostToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :type_post, :integer
    add_index :posts, :type_post
  end
end
