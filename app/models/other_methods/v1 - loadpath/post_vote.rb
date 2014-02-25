class PostVote < ActiveRecord::Base
  attr_accessible :post_id, :user_id, :vote
end
