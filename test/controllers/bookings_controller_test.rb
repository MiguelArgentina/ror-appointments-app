require "test_helper"

class BookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:provider)
    @booking = bookings(:one)
  end

  test "should get index" do
    get bookings_url
    assert_response :success
  end

  test "should get new" do
    get new_booking_url
    assert_response :success
  end

  test "should create booking" do
    assert_difference("Booking.count") do
      booking_type = booking_types(:free)
      user = users(:client)
      provider = users(:provider)
      post bookings_url, params: { booking: {provider_id: provider.id, user_id: user.id, booking_type_id: booking_type.id, code: @booking.code, owes_payment: @booking.owes_payment, start_time: @booking.start_time } }
    end

    assert_redirected_to booking_url(Booking.last)
  end

  test "should show booking" do
    get booking_url(@booking)
    assert_response :success
  end

  test "should get edit" do
    get edit_booking_url(@booking)
    assert_response :success
  end

  test "should update booking" do
    patch booking_url(@booking), params: { booking: { code: @booking.code, owes_payment: @booking.owes_payment, start_time: @booking.start_time } }
    assert_redirected_to booking_url(@booking)
  end

  test "should destroy booking" do
    assert_difference("Booking.count", -1) do
      delete booking_url(@booking)
    end

    assert_redirected_to bookings_url
  end
end
