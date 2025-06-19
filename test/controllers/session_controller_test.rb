require "test_helper"

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "should get online" do
    get session_online_url
    assert_response :success
  end

  test "should get offline" do
    get session_offline_url
    assert_response :success
  end
end
