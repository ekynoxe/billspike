require 'spec_helper'

describe Share do
  before(:each) do
    @valid_attributes = {
      :name=>'my share'
    }
    @share = Share.new
  end

  it "should be valid given valid attributes" do
    @share.attributes = @valid_attributes
    @share.should be_valid
  end

  it "should not be valid without a name" do
    @share.attributes = @valid_attributes.except(:name)
    @share.should_not be_valid
    @share.name = "my other share name"
    @share.should be_valid
  end
  
  it "should total 0 with no items" do
    @share.total.should == 0
  end
  
  it "should return the sum of its item values" do
    @share.items.create({:value=>2545, :description => 'foo'})
    @share.items.create({:value=>3555, :description => 'bar'})
    @share.items.length.should == 2
    @share.total.should == 6100
  end
  
  it "should have no participants" do
    @share.participations.length.should == 0
  end
  
  it "should give the amount per participant" do
    @share.amount_per_participant.should be nil
  end
end

describe "Share with participants" do
  before(:each) do
    @valid_attributes = {
      :name=>'my share'
    }
    @share = Share.create(@valid_attributes)
    @user1 = User.create({:username=>'matt',:password=>'mypassword',:password_confirmation=>'mypassword',:email=>'matt@ekynoxe.com'})
    @user2 = User.create({:username=>'pilot',:password=>'mypassword',:password_confirmation=>'mypassword',:email=>'pilot@ekynoxe.com'})

    @share.participations.create({:user=>@user1})
    @share.participations.create({:user=>@user2})
  end

  it "should have 2 participants" do
    @share.participations.length.should == 2
  end
  
  it "should give the amount per participant" do
    @item1=@user1.items.build({:value=>2545,:description=>'new item 1'})
    @item2=@user1.items.build({:value=>3555,:description=>'new item 2'})
    @item3=@user2.items.build({:value=>4000,:description=>'new item 3'})
    
    @share.contributions.create!(:user=>@user1, :item=>@item1)
    @share.contributions.create!(:user=>@user1, :item=>@item2)
    @share.contributions.create!(:user=>@user2, :item=>@item3)
    
    @share.amount_per_participant.should == 5050
  end
end