require 'test_helper'

class ResoursesControllerTest < ActionController::TestCase
  test "should get add_resourses" do
    get :add_resourses
    assert_response :success
  end

end
