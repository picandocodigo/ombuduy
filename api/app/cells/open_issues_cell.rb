class OpenIssuesCell < Cell::Rails

  def display
    @issues = Issue.order("fixed ASC").limit(20)
    render
  end

end
