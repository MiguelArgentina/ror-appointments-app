require "test_helper"

class BookingTypesControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in users(:provider)
    @booking_type = booking_types(:one_hour)
  end

  test 'if not signed in,  should redirect' do
    sign_out users(:provider)
    get booking_types_url
    assert_response :redirect
  end

  test "should get index" do
    get booking_types_url
    assert_response :success
  end

  test "should get new" do
    get new_booking_type_url
    assert_response :success
  end

  test "should create booking_type" do
    assert_difference("BookingType.count") do
      post booking_types_url, params: { booking_type: { cost_id: @booking_type.cost_id, duration: @booking_type.duration, name: @booking_type.name, user_id: @booking_type.user_id } }
    end

    assert_redirected_to booking_type_url(BookingType.last)
  end

  test "should show booking_type" do
    get booking_type_url(@booking_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_booking_type_url(@booking_type)
    assert_response :success
  end

  test "should update booking_type" do
    patch booking_type_url(@booking_type), params: { booking_type: { cost_id: @booking_type.cost_id, duration: @booking_type.duration, name: @booking_type.name, user_id: @booking_type.user_id } }
    assert_redirected_to booking_type_url(@booking_type)
  end

end
