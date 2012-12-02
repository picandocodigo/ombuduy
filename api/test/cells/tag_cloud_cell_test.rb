require 'test_helper'

class TagCloudCellTest < Cell::TestCase
  test "display" do
    invoke :display
    assert_select "p"
  end
  

end
