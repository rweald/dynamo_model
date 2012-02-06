#DynamoModel

[![Build Status](https://secure.travis-ci.org/rweald/dynamo_model.png?branch=master)](http://travis-ci.org/rweald/dynamo_model)

Provies a simple object oriented abstraction that allows you to persist objects to DynamoDB.

This is not a complete drop in replacement for ActiveRecord. 

Instead it focuses on allowing a plugable persistence mechanism for a domain model that was
designed for polyglot presistance strategies. 

##Usage

### Basic Usage

Using DynamoModel is easy. All you have to do is create a ruby class.

```ruby
class Tweet
  include DynamoModel::Properties
  include DynamoModel::Persistence

  property :content
  property :twitter_user_id

  #You can provide a default value for your properties
  property :followers_count, :default => 0

  # Dynamo can only store Strings, Numbers, and Array.
  # If you want to store anything else you have to provide a custom converter 
  # This converter allows you to store anything that can be converted to on of the 
  # dynamo compatible types
  property :posted_at, :conversion => proc { |v| v.to_s }

end

#Now you can just create an object and save it
Tweet.new(:content => "I saw justin beiber", :twitter_user_id => "123456").save

```

###Migrations
DynamoMigration provides a convienient way to create dynamo tables as
part of your rails migrations.

```ruby

class CreateTweetTable < ActiveRecord::Migration
  include DynamoModel::Migrations

  self.up
    create_dynamo_table :tweets
  end
end

end
