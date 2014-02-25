class CreateApiV1Posts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :user_id
      t.text :content

      t.timestamps
    end
  end
end
