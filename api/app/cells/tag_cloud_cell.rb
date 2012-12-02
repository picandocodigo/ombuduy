class TagCloudCell < Cell::Rails

  def display
    @tags = Tag.limit(20)
    render
  end

end
