require 'spec_helper'
require 'dynamo_model/migration'

describe DynamoModel::Migrations do
  class TestMigration
    include DynamoModel::Migrations

    def self.up
      create_dynamo_table :people
    end

    def self.up_with_capacity
      create_dynamo_table :people, :read_capacity => 20, :write_capacity => 40
    end
  end

  describe ".create_dynamo_table" do
    let(:fake_dynamo_migration) { double(DynamoModel::Migration) }
    before do
      DynamoModel::Migration.stub(:new => fake_dynamo_migration)
    end

    it "should create a dynamo table with the given name" do
      fake_dynamo_migration.should_receive(:create_table).with("people", 5 , 5)

      TestMigration.up
    end

    it "should allow the user to set the read and write capacity" do
      fake_dynamo_migration.should_receive(:create_table).with("people", 20, 40)
      TestMigration.up_with_capacity
    end
  end

end

describe DynamoModel::Migration do
  let(:fake_table_collection) { double("Fake dynamo table collection") }
  let(:fake_connection) { double("Fake Dynamo Connection", :tables => fake_table_collection) }

  describe "#initialize" do
    subject { DynamoModel::Migration }
    it "should open up a connection to AWS Dynamo DB" do
      DynamoModel::Connection.should_receive(:create_from_config).and_return(fake_connection)
      subject.new
    end
  end

  describe "#create_table" do
    before do
      DynamoModel::Connection.stub(:create_from_config => fake_connection)
    end

    it "should create a table with the given name on aws"  do
      fake_table_collection.should_receive(:create) do |name, read_capacity, write_capacity|
        name.should == "foobar"
        read_capacity.should == 10
        write_capacity.should == 20
      end
      subject.create_table("foobar", 10, 20)
    end
  end

end
