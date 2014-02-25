class PostVote < ActiveRecord::Base
  attr_accessible :post_id, :user_id, :vote
  
  belongs_to :post
  validates_uniqueness_of :user_id, :scope => [:post_id], :message => :already_voted
  validates :vote, inclusion: { in: [0, 1,-1] }
  
end
