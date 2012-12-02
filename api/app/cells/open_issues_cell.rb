class OpenIssuesCell < Cell::Rails

  def display
    @issues = Issue.order(:relevance).limit(20)
    render
  end

end
