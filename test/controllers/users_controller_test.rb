require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @base_title = "| Andrew's Sample Site"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", "Sign Up #{@base_title}"
  end

  
end
