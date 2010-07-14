require 'spec_helper'

describe User do
  
  before(:each) do
    @valid_attributes = {
      :username=>'matt',
      :password=>'mypassword',
      :password_confirmation=>'mypassword',
      :email=>'matt@ekynoxe.com'
    }
    @user = User.new
  end

  it "should be valid given valid attributes" do
    @user.attributes = @valid_attributes
    @user.should be_valid
  end
  
  it "should not be valid without a user name" do
    @user.attributes = @valid_attributes.except(:username)
    @user.should_not be_valid
    @user.username = "someusername"
    @user.should be_valid
  end
  
  it "should not be valid without an email" do
    @user.attributes = @valid_attributes.except(:email)
    @user.should_not be_valid
    @user.email = "matt@ekynoxe.com"
    @user.should be_valid
  end
  
  it "should not be valid without a password" do
    @user.attributes = @valid_attributes.except(:password)
    @user.should_not be_valid
    @user.password = "mypassword"
    @user.should be_valid
  end
  
  it "should not be valid without a password confirmation" do
    @user.attributes = @valid_attributes.except(:password_confirmation)
    @user.should_not be_valid
    @user.password_confirmation = "mypassword"
    @user.should be_valid
  end
  
  it "should not be able to change its password without a password confirmation" do
    @user.attributes = @valid_attributes
    @user.should be_valid
    @user.update_attributes({:password=>'test'})
    @user.should_not be_valid
  end
  
  it "should be able to change its password" do
    @user.attributes = @valid_attributes
    @user.should be_valid
    @user.update_attributes({:password=>'test',:password_confirmation=>'test'})
    @user.should be_valid
  end
  
  it "should be able to update its name" do
    @user.attributes = @valid_attributes
    @user.should be_valid
    @user.update_attributes({:username=>'pilot'})
    @user.should be_valid
    @user.username.should == 'pilot'
  end
  
  it "should be able to update its email" do
    @user.attributes = @valid_attributes
    @user.should be_valid
    @user.update_attributes({:username=>'pilot@ekynoxe.com'})
    @user.should be_valid
    @user.username.should == 'pilot@ekynoxe.com'
  end
  
  it "should be able to query for its items" do
    @user.should respond_to(:items)
    @user.items.create({:value=>3,:description=>"foo"})
    @user.should have(1).item
  end
end


describe "User with items" do
  before(:each) do
    @valid_attributes = {
      :username=>'matt',
      :password=>'mypassword',
      :password_confirmation=>'mypassword',
      :email=>'matt@ekynoxe.com'
    }
    @user = User.create(@valid_attributes)
    
    @share1 = Share.create({:name=>'my share 1'})
    @share2 = Share.create({:name=>'my share 2'})
    
    @item1 = Item.create({:value=>2345,:description=>'item 1'})
    @item2 = Item.create({:value=>3345,:description=>'item 2'})
    @item3 = Item.create({:value=>6545,:description=>'item 3'})

    @user.contributions.create({:item=>@item1,:share=>@share1})
    @user.contributions.create({:item=>@item2,:share=>@share1})
    @user.contributions.create({:item=>@item3,:share=>@share2})
  end

  it "should have 2 items" do
    @user.contributions.length.should == 3
  end
  
  it "should get the grand total" do
    @user.grand_total.should == 12235
  end
  
  it "should get the total for share 1" do
    @user.total_for_share(1).should == 5690
  end
  
  it "should be admin" do
    @share1.participations.create({:user=>@user, :admin=>true})
    @user.is_admin_for(1).should be true
  end
  
  it "should not be admin" do
    @user.is_admin_for(1).should_not be true
  end
end