require 'spec_helper'

describe DynamoModel::Property do
  
  subject { DynamoModel::Property }

  describe "#initialize" do
    it "should raise an Error if try an set an incompatible type as the default" do
      lambda { subject.new("FooBar", DateTime.now) }.should raise_error
    end 

    it "should not raise an error if a custom conversion proc is passed in to convert the default value" do
      lambda { 
        prop = subject.new("Foobar", Date.today, :conversion => proc { |v| v.to_s })
      }.should_not raise_error
    end 

    it "should store the value and not raise an error if type is valid" do
      lambda { subject.new("FooBar", 1.0) }.should_not raise_error(/Invalid Dynamo Type/)
    end

    it "should store a custom encoded value as the default value if a conversion proc is passed in" do
      prop = subject.new("Foobar", Date.today, :conversion => proc { |v| v.to_s })
      prop.default_value.should == Date.today.to_s
    end
  end

  describe "#convert_value" do
    subject { DynamoModel::Property.new("Foobar", "HelloWorld", :conversion => proc { |v| v.to_s }) }
    it "should return the same value if the value passed in is already in valid format" do
      subject.convert_value(1).should == 1
    end

    it "should return the converted value if a value is passed in and a converter exists" do
      subject.convert_value(Date.today).should == Date.today.to_s
    end

    it "should raise an error if the converted type is still invalid" do
      prop = DynamoModel::Property.new("Foobar", "hello world", :conversion => proc { Date.today })
      lambda { prop.convert_value(Date.today) }.should raise_error(/Invalid Dynamo Type/)
    end

    it "should raise an erorr if passed an invalid type and no converter is defined" do
      prop = DynamoModel::Property.new("Foobar", "hello")
      lambda { prop.convert_value(Date.today) }.should raise_error(/Invalid Dynamo Type/)
    end
  end

end
