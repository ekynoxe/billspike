require 'spec_helper'

describe Payment do
  before(:each) do
    @valid_attributes = {
      :value=>23.45
    }
    @payment = Payment.new
  end

  it "should be valid given valid attributes" do
    @payment.attributes = @valid_attributes
    @payment.should be_valid
  end
  
  it "should not be valid without a value" do
    @payment.attributes = @valid_attributes.except(:value)
    @payment.should_not be_valid
  end
  
  it "should not be valid with a non numerical value" do
    @payment.attributes = @valid_attributes.except(:value)
    @payment.value = "string value"
    @payment.should_not be_valid
  end
  
  it "should be able to query for its owner" do
    @payment.should respond_to(:user)
  end
end
