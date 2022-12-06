require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get home_welcome_url
    assert_response :success
  end

  test "to get dashboard should be signed in " do
    get home_dashboard_url
    assert_response :redirect
  end

  test "should get dashboard if signed_in" do
    sign_in users(:client)
    get home_dashboard_url
    assert_response :success
  end
end
