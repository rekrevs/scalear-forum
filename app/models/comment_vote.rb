class CommentVote < ActiveRecord::Base
  attr_accessible :comment_id, :user_id, :vote
  
  belongs_to :comment
end
