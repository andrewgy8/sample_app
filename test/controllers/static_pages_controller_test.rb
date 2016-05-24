require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
<<<<<<< HEAD
  
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Andrew's Sample Site"
=======
  def setup
    @base_title = "| Andrew's Sample Site"
  end 
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Home #{@base_title}"
>>>>>>> static-pages-excercises
  end

  test "should get help" do
    get :help
    assert_response :success
<<<<<<< HEAD
    assert_select "title", "Andrew's Sample Site"
=======
    assert_select "title", "Help #{@base_title}"
>>>>>>> static-pages-excercises
  end

  test "should get about" do
    get :about
    assert_response :success
<<<<<<< HEAD
    assert_select "title", "Andrew's Sample Site"
=======
    assert_select "title", "About #{@base_title}"
  end

  test "should get contact" do 
    get :contact
    assert_response :success
    assert_select "title", "Contact #{@base_title}"
>>>>>>> static-pages-excercises
  end
end
