require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "cleanup_twitter" do
    
    @clean_twitter = 'rdohms'
    
    @user = User.new

    @user.twitter = "@rdohms"
    @user.cleanup_twitter
    assert_equal(@clean_twitter, @user.twitter )
    
    @user.twitter = "http://twitter.com/rdohms"
    @user.cleanup_twitter
    assert_equal(@clean_twitter, @user.twitter )
    
    @user.twitter = "http://www.twitter.com/rdohms"
    @user.cleanup_twitter
    assert_equal(@clean_twitter, @user.twitter )
    
    @user.twitter = "http://www.twitter.com/rdohms/"
    @user.cleanup_twitter
    assert_equal(@clean_twitter, @user.twitter )
    
    @user.twitter = "http://twitter.com/rdohms/"
    @user.cleanup_twitter
    assert_equal(@clean_twitter, @user.twitter )
  end
end
