require "application_system_test_case"

class BookingTypesTest < ApplicationSystemTestCase
  setup do
    @booking_type = booking_types(:one)
  end

  test "visiting the index" do
    visit booking_types_url
    assert_selector "h1", text: "Booking types"
  end

  test "should create booking type" do
    visit booking_types_url
    click_on "New booking type"

    fill_in "Cost", with: @booking_type.cost_id
    fill_in "Duration", with: @booking_type.duration
    check "Free" if @booking_type.free
    fill_in "Name", with: @booking_type.name
    fill_in "User", with: @booking_type.user_id
    click_on "Create Booking type"

    assert_text "Booking type was successfully created"
    click_on "Back"
  end

  test "should update Booking type" do
    visit booking_type_url(@booking_type)
    click_on "Edit this booking type", match: :first

    fill_in "Cost", with: @booking_type.cost_id
    fill_in "Duration", with: @booking_type.duration
    check "Free" if @booking_type.free
    fill_in "Name", with: @booking_type.name
    fill_in "User", with: @booking_type.user_id
    click_on "Update Booking type"

    assert_text "Booking type was successfully updated"
    click_on "Back"
  end

  test "should destroy Booking type" do
    visit booking_type_url(@booking_type)
    click_on "Destroy this booking type", match: :first

    assert_text "Booking type was successfully destroyed"
  end
end
