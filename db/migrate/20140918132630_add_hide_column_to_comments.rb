class AddHideColumnToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :hide, :boolean, :default => true
  end
end
