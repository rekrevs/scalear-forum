class Api::V2::Post < ActiveRecord::Base
  attr_accessible :content, :user_id
end
