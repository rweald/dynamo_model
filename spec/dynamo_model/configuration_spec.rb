require 'spec_helper'

require 'dynamo_model/configuration'

describe DynamoModel::Configuration do

  describe ".load_configuration" do
    subject { DynamoModel::Configuration }
    before do
      File.stub(:read)
      YAML.stub(:load).and_return({})
    end
    it "should read config from 'config/dynamo_db.yml' by default" do
      File.should_receive(:read).with("config/dynamo_db.yml")
      subject.load_configuration
    end

    it "should read config from custom file if specified" do
      File.should_receive(:read).with("foo/bar.yml")
      subject.load_configuration("foo/bar.yml")
    end

    it "should store results of yml config as part of configuration object" do
      YAML.stub(:load).and_return({"development" => { "password" => "foobar" }})
      subject.load_configuration.config["development"]["password"].should == "foobar"
    end
  end

end
