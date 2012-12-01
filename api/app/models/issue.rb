class Issue < ActiveRecord::Base
  
  attr_accessible :text

  has_and_belongs_to_many :tags
  has_many :replies
  
  has_one :user
end
