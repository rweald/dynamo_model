require 'spec_helper'

describe DynamoModel do
  subject { DynamoModel }

  describe ".environment" do
    
    context "Rails is defined" do
      let(:fake_rails) { double("fake rails", :env => "production") }
      after(:all) do
        Object.send(:remove_const, :Rails)
      end
      it "should return the rails enviroment" do
        Rails = fake_rails
        subject.environment.should == "production"
      end
    end

    context "Rails is not defined" do
      it "should return the DYNAMO_ENV value" do
        ENV["DYNAMO_ENV"] = "test"
        subject.environment.should == "test"
      end
    end

  end
end
