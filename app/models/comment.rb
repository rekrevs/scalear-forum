class Comment < ActiveRecord::Base
  attr_accessible :content,:lecture_id, :post_id, :user_id, :hide
  has_many :comment_votes, :dependent => :destroy
  has_many :comment_flags, :dependent => :destroy
  belongs_to :post  
  
  attr_accessor :current_user_id
  
  def votes_count
      return comment_votes.pluck(:vote).reduce(0,:+)
  end
  
  def flags_count
      return comment_flags.count
  end
  
  def user_vote
      v= comment_votes.where(:user_id => current_user_id)[0]
      puts v
      puts comment_votes.inspect
      puts "VOTES!!!!"
      puts current_user_id
      if v.nil?
          return 0
          else
          return v.vote
      end
  end
  
  def user_flag
      v= comment_flags.where(:user_id => current_user_id)[0]
      if v.nil?
          return 0
          else
          return 1
      end
  end

end
