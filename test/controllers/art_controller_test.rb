require "test_helper"

class ArtControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get art_index_url
    assert_response :success
  end

  test "should get new" do
    get art_new_url
    assert_response :success
  end

  test "should get create" do
    get art_create_url
    assert_response :success
  end

  test "should get show" do
    get art_show_url
    assert_response :success
  end
end
