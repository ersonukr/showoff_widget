require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_create_url
    assert_response :success
  end

  test "should get reset_password" do
    get users_reset_password_url
    assert_response :success
  end

end
