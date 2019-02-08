class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.references :district, foreign_key: true
      t.string :title
      t.string :description
      t.string :img
      t.integer :status
      t.datetime :datetime_lost
      t.integer :category
      t.timestamps
    end
    add_index :posts, :title
    add_index :posts, :status
    add_index :posts, :category
  end
end
