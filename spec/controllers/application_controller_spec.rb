require 'spec_helper'

describe ApplicationController, "with params[:item] or params[:payment] set" do
  before(:each) do
    @params={:item => {:description=>"my item"},:payment => {}}
  end
  
  it "should return a string value as the same string" do
    @params[:item][:value] = "foo"
    @params[:payment][:value] = "foo"
    filter
    @params[:item][:value].should == "foo"
    @params[:payment][:value].should == "foo"
  end
  
  it "should return a value of 12 for an input of '0.12'" do
    @params[:item][:value] = "0.12"
    @params[:payment][:value] = "0.12"
    filter
    @params[:item][:value].should == 12
    @params[:payment][:value].should == 12
  end

  it "should return a value of 12 for an input of '0.12345'" do
    @params[:item][:value] = "0.12345"
    @params[:payment][:value] = "0.12345"
    filter
    @params[:item][:value].should == 12
    @params[:payment][:value].should == 12
  end

  it "should return a value of 400 for an input of '4.00'" do
    @params[:item][:value] = "4.00"
    @params[:payment][:value] = "4.00"
    filter
    @params[:item][:value].should == 400
    @params[:payment][:value].should == 400
  end
  
  it "should return a value of 400 for an input of '4'" do
    @params[:item][:value] = "4"
    @params[:payment][:value] = "4"
    filter
    @params[:item][:value].should == 400
    @params[:payment][:value].should == 400
  end
  
  it "should return a value of 412 for an input of '4.12345'" do
    @params[:item][:value] = "4.12345"
    @params[:payment][:value] = "4.12345"
    filter
    @params[:item][:value].should == 412
    @params[:payment][:value].should == 412
  end

end

def filter
  @params[:item] = controller.filter_units_inputs(@params[:item]) unless @params[:item].blank?
  @params[:payment] = controller.filter_units_inputs(@params[:payment]) unless @params[:payment].blank?
end