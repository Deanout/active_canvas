require "application_system_test_case"

class DrawingsTest < ApplicationSystemTestCase
  setup do
    @drawing = drawings(:one)
  end

  test "visiting the index" do
    visit drawings_url
    assert_selector "h1", text: "Drawings"
  end

  test "should create drawing" do
    visit drawings_url
    click_on "New drawing"

    fill_in "Title", with: @drawing.title
    click_on "Create Drawing"

    assert_text "Drawing was successfully created"
    click_on "Back"
  end

  test "should update Drawing" do
    visit drawing_url(@drawing)
    click_on "Edit this drawing", match: :first

    fill_in "Title", with: @drawing.title
    click_on "Update Drawing"

    assert_text "Drawing was successfully updated"
    click_on "Back"
  end

  test "should destroy Drawing" do
    visit drawing_url(@drawing)
    click_on "Destroy this drawing", match: :first

    assert_text "Drawing was successfully destroyed"
  end
end
