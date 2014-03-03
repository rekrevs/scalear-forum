class Post < ActiveRecord::Base
    attr_accessible :content, :user_id,:lecture_id, :privacy, :time
  has_many :post_votes, :dependent => :destroy
  has_many :post_flags, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  attr_accessor :current_user_id
  
  def votes_count
      return post_votes.pluck(:vote).reduce(0,:+)
  end
  
  def flags_count
      return post_flags.count
  end
  
  def user_vote
      v= post_votes.where(:user_id => current_user_id)[0]
      if v.nil?
          return 0
      else
          return v.vote
      end
  end
  
  def user_flag
      v= post_flags.where(:user_id => current_user_id)[0]
      if v.nil?
          return 0
          else
          return 1
      end
  end
  
end
