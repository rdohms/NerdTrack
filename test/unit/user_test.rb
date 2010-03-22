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
  
  test "valid_username" do
    
    @clean_twitter = 'rdohms'
    
    @user = User.new do |u|
        u.name = "David"
        u.email = "email@email.com"
        u.twitter = "John"
        u.password = "1234567890"
      end


    @user.username = "rdohmsssss"
    assert_equal true, @user.valid?, @user.errors.inspect

    @user.username = "rdohms32"
    assert_equal true, @user.valid?, @user.errors.inspect

    @user.username = "John_McLane"
    assert_equal true, @user.valid?, @user.errors.inspect
    
    @user.username = "@rdohms"
    assert_equal false, @user.valid?, @user.errors.inspect
    
    @user.username = "Rafael Dohms"
    assert_equal false, @user.valid?, @user.errors.inspect
    
    @user.username = "Ação"
    assert_equal false, @user.valid?, @user.errors.inspect
    
    @user.username = "John-McLane"
    assert_equal false, @user.valid?, @user.errors.inspect
    
    @user.username = "John-ˆ"
    assert_equal false, @user.valid?, @user.errors.inspect
    
    @user.username = "john.locke"
    assert_equal false, @user.valid?, @user.errors.inspect
  end
end
