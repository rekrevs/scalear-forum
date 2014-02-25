class Comment < ActiveRecord::Base
  attr_accessible :content, :post_id, :user_id
  
  has_many :comment_votes, :dependent => :destroy
  belongs_to :post
end
