class CreateApiV1PostFlags < ActiveRecord::Migration
  def change
    create_table :post_flags do |t|
      t.string :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
