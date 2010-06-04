require 'test_helper'
require 'shoulda'

class ItemTest < Test::Unit::TestCase
  
  should_belong_to :user
  
  context "An Item instance" do
    setup do
      @item = Factory.stub(:item)
    end

    should "return its value" do
      assert_equal 1.3, @item.value
    end

    should "return its description" do
      assert_equal 'milk', @item.description
    end
    
    should "return its currency_id" do
      assert_equal 1, @item.currency_id
    end
  end
end