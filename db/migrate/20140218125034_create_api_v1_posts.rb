class CreateApiV1Posts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :content
      t.float :time
      t.integer :lecture_id
      t.string :privacy

      t.timestamps
    end
  end
end
