require 'spec_helper'

describe DynamoModel::Properties do
  class Tweet
    include DynamoModel::Properties
    
    property :content
    property :posted_at, :default => DateTime.now, :conversion => proc { |v| v.to_s }
  end

  describe ".property" do
    let(:tweet) { Tweet.new }

    it "should create a getter with the name provided to property call" do
      tweet.should respond_to(:content)
    end

    it "should create a setter for the given property name" do
      tweet.should respond_to(:content=)
    end

    it "should return the default value if a normal value has not been set" do
      tweet.posted_at.to_date.should == DateTime.today.to_date
    end
    
  end
  
end
