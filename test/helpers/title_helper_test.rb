require 'test_helper'

class TitleHelperTest < ActionView::TestCase
  include ApplicationHelper

  test "is valid with proper title" do
    params[:controller] = "lorem_ipsum"
    assert_equal "Lorem ipsum - Bootcamp App", page_title
  end
end
