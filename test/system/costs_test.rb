require "application_system_test_case"

class CostsTest < ApplicationSystemTestCase
  setup do
    @cost = costs(:one)
  end

  test "visiting the index" do
    visit costs_url
    assert_selector "h1", text: "Costs"
  end

  test "should create cost" do
    visit costs_url
    click_on "New cost"

    fill_in "Amount", with: @cost.amount
    fill_in "Currency", with: @cost.currency
    fill_in "Start date", with: @cost.start_date
    click_on "Create Cost"

    assert_text "Cost was successfully created"
    click_on "Back"
  end

  test "should update Cost" do
    visit cost_url(@cost)
    click_on "Edit this cost", match: :first

    fill_in "Amount", with: @cost.amount
    fill_in "Currency", with: @cost.currency
    fill_in "Start date", with: @cost.start_date
    click_on "Update Cost"

    assert_text "Cost was successfully updated"
    click_on "Back"
  end

  test "should destroy Cost" do
    visit cost_url(@cost)
    click_on "Destroy this cost", match: :first

    assert_text "Cost was successfully destroyed"
  end
end
