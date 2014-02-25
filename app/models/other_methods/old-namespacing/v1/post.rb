class Api::V1::Post < ActiveRecord::Base
  attr_accessible :content, :user_id
end
