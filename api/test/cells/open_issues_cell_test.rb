require 'test_helper'

class OpenIssuesCellTest < Cell::TestCase
  test "display" do
    invoke :display
    assert_select "p"
  end
  

end
