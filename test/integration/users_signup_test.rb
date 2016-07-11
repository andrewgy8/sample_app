require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  #get the sign_up page... not absolutely necessary since the post works without it in the test.  
  #serves to double check the signup page load properly
  test 'invalid signup from user' do
    get signup_path
    assert_no_difference 'User.count' do
      # makes sure the user.count is the same before and after the user post is executed.
      post users_path, user: {  name: '',
                                email: 'user@invalid.com',
                                password: 'foo',
                                password_confirmation: 'bar'
                              }                       
    end
    
    assert_template 'users/new'
    assert_select "div#<error_explanation>"
  end

  test 'Signup is successful with valid user' do
    get signup_path
    assert_difference 'User.count' do
      #follow the redirect in the test
      post_via_redirect users_path, user: { name: 'Example',
                                email: 'example@example.com',
                                password: 'foobar',
                                password_confirmation: 'foobar'
                              }
    end
    assert_template 'users/show'
    assert is_logged_in?
    
  end

end
