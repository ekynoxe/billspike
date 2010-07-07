require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :username=>'matt',
      :password=>'mypassword',
      :password_confirmation=>'mypassword',
      :email=>'matt@ekynoxe.com'
    }
  end
  
  it "should be invalid without a user name" do
    @user = User.new
    @user.attributes = @valid_attributes.except(:username)
    @user.should_not be_valid
    @user.username = "someusername"
    @user.should be_valid
  end
  
  
  it "should be invalid without an email" do
    @user = User.new
    @user.attributes = @valid_attributes.except(:email)
    @user.should_not be_valid
    @user.email = "matt@ekynoxe.com"
    @user.should be_valid
  end
  
  it "should be invalid without a password" do
    @user = User.new
    @user.attributes = @valid_attributes.except(:password)
    @user.should_not be_valid
    @user.password = "mypassword"
    @user.should be_valid
  end

  it "should be invalid without a password confirmation" do
    @user = User.new
    @user.attributes = @valid_attributes.except(:password_confirmation)
    @user.should_not be_valid
    @user.password_confirmation = "mypassword"
    @user.should be_valid
  end
end
