require 'spec_helper'
require 'dynamo_model'

describe DynamoModel::Connection do
  subject { DynamoModel::Connection }

  describe ".create" do
    it "should create a connection to AWS DynamoDB" do
      AWS::DynamoDB.should_receive(:new)
      subject.create(:access_key => "hello",
                                     :secret_key => "world")
    end
  end

  describe ".create_from_config" do
    let(:fake_rails) { double("Fake Rails env object", :env => "production") }
    let(:fake_configuration) do
      double("fake config", :config => 
             {"test" => {
               "access_key" => "hello", 
               "secret_key" => "world"
             },
              "production" => {
                 "access_key" => "foo",
                 "secret_key" => "bar"}
             })
    end

    before do
      DynamoModel::Configuration.stub(:load_configuration => fake_configuration)
    end

    it "should load the configuration info using the configuration class" do
      DynamoModel::Configuration.should_receive(:load_configuration)
      subject.create_from_config
    end

    it "should use the dynamo env if rails env is not defined" do
      AWS::DynamoDB.should_receive(:new) do |credentials|
        credentials[:access_key_id].should == "hello"
        credentials[:secret_access_key].should == "world"
      end
      subject.create_from_config
    end

    it "should use rails env to access specific config if Rails is available" do
      Rails = fake_rails
      AWS::DynamoDB.should_receive(:new) do |credentials|
        credentials[:access_key_id].should == "foo"
        credentials[:secret_access_key].should == "bar"
      end
      subject.create_from_config
    end

  end

end
