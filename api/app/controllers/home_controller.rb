class HomeController < ApplicationController

  def index
    @issues = Issue.order("updated_at DESC").limit(10)
  end

end
