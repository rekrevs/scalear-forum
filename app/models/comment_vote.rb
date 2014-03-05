class CommentVote < ActiveRecord::Base
  attr_accessible :comment_id, :user_id, :vote
  
  belongs_to :comment
  validates_uniqueness_of :user_id, :scope => [:comment_id], :message => :already_voted
  validates :vote, inclusion: { in: [0, 1,-1] }
end
