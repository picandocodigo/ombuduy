class Issue < ActiveRecord::Base
  
  attr_accessible :text, :fixed, :relevance, :address, :longitude, :latitude, :image_url, :user_id, :tweet_id

  has_and_belongs_to_many :tags
  has_many :replies
  
  has_one :user
end
