require 'test_helper'

class WidgetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get widgets_index_url
    assert_response :success
  end

  test "should get create" do
    get widgets_create_url
    assert_response :success
  end

end
