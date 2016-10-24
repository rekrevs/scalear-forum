class AddCourseIdModuleIdInPost < ActiveRecord::Migration
  def up
	add_column :posts, :course_id, :integer, :default => nil
	add_column :posts, :group_id, :integer, :default => nil
  end

  def down
    remove_column :posts, :course_id
    remove_column :posts, :group_id
  end
end
