class CreateApiV1CommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.integer :user_id
      t.integer :comment_id
      t.integer :vote

      t.timestamps
    end
  end
end
