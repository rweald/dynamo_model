require 'spec_helper'
require 'dynamo_model/connection'

describe DynamoModel::Connection do

  describe ".create" do
    it "should create a connection to AWS DynamoDB" do
      AWS::DynamoDB.should_receive(:new)
      DynamoModel::Connection.create(:access_key => "hello",
                                     :secret_key => "world")
    end
  end

end
