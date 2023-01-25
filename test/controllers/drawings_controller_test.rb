require "test_helper"

class DrawingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drawing = drawings(:one)
  end

  test "should get index" do
    get drawings_url
    assert_response :success
  end

  test "should get new" do
    get new_drawing_url
    assert_response :success
  end

  test "should create drawing" do
    assert_difference("Drawing.count") do
      post drawings_url, params: { drawing: { title: @drawing.title } }
    end

    assert_redirected_to drawing_url(Drawing.last)
  end

  test "should show drawing" do
    get drawing_url(@drawing)
    assert_response :success
  end

  test "should get edit" do
    get edit_drawing_url(@drawing)
    assert_response :success
  end

  test "should update drawing" do
    patch drawing_url(@drawing), params: { drawing: { title: @drawing.title } }
    assert_redirected_to drawing_url(@drawing)
  end

  test "should destroy drawing" do
    assert_difference("Drawing.count", -1) do
      delete drawing_url(@drawing)
    end

    assert_redirected_to drawings_url
  end
end
