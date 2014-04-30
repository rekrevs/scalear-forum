class AddHideColumnToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :hide, :boolean, :default => false
  end
end
