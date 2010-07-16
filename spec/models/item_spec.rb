require 'spec_helper'

describe Item do
  before(:each) do
    @valid_attributes = {
      :value=>2345,
      :description=>'new item'
    }
    @item = Item.new
  end

  it "should be valid given valid attributes" do
    @item.attributes = @valid_attributes
    @item.should be_valid
    @item.value.should == 2345
  end
  
  it "should not be valid without a value" do
    @item.attributes = @valid_attributes.except(:value)
    @item.should_not be_valid
  end
  
  it "should not be valid with a non numerical value" do
    @item.attributes = @valid_attributes.except(:value)
    @item.value = "string value"
    @item.should_not be_valid
  end
  
  it "should not be valid without a description" do
    @item.attributes = @valid_attributes.except(:description)
    @item.should_not be_valid
  end
  
  it "should be able to query for its owner" do
    @item.should respond_to(:user)
  end
end
