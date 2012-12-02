class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :provider, :uid
  
  def provider_name
      provider.titleize
  end

end
