ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user, options={})
    #options argument of password is taken as password, else the password is set to 'password'
    #this applies to whether or not the remember me box is checked
    password = options[:password] || 'password'
    #'1' is the default value of the remember me icon, so therefore this is automatically remember
    remember_me = options[:remember_me] || '1'
    #uses the private method below
    if integration_test?

      post login_path, session: {   email: user.email,
                                    password: password,
                                    remember_me: remember_me
                                  }
    else
      #non-integration tests can not post directly to the sessions path,
      session[:user_id] = user.id
    end
  end
  # Add more helper methods to be used by all tests here...

  private
  #inorder to determine if the test is integration or not, we can use a method that only works for integration test
  #this will return true if it is an integration test, or false otherwise

    def integration_test?
      defined?(post_via_redirect)
    end
end
