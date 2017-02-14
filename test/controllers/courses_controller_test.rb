require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get building-a-website" do
    get :building-a-website
    assert_response :success
  end

  test "should get getting-started-with-linux" do
    get :getting-started-with-linux
    assert_response :success
  end

  test "should get web-design-and-development" do
    get :web-design-and-development
    assert_response :success
  end

end
