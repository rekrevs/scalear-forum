class CreateApiV1Comments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :content
      t.integer :lecture_id
      t.integer :post_id

      t.timestamps
    end
  end
end
