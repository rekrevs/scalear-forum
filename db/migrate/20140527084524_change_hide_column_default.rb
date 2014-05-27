class ChangeHideColumnDefault < ActiveRecord::Migration
  def change
  	change_column_default :posts, :hide, true
  end
end
