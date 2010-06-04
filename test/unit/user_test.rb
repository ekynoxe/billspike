require 'test_helper'
require 'shoulda'

class UserTest < Test::Unit::TestCase
  
  should_have_many :items
  
  context "A User instance" do
    setup do
      @user = Factory.stub(:user)
    end

    should "return its username" do
      assert_equal 'matt', @user.username
    end
    
    should "return its email" do
      assert_equal 'matt@ekynoxe.com', @user.email
    end
  
    should "not be an admin" do
      assert_equal false, @user.admin
    end
  
    context " with items" do
      setup do
        @user.items = Item.find(:all)
      end
      
      should "be able to count its items" do
        assert_equal 1, @user.items.length
      end
    end
  end

  context "An Admin instance" do
    setup do
      @admin = Factory.stub(:admin)
    end

    should "say it's an admin" do
      assert_equal true, @admin.admin
    end
  end
  
  
  context "Creating a user" do
    should "not be possible without an email" do
      user = User.new()
      
    end
  end
end