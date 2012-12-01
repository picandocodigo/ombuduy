class Issue < ActiveRecord::Base
  has_many :tags
  has_many :replies

  has_one :user
end
